//
//  AVAudioRecorderController.m
//  AVFunction
//
//  Created by shoule on 2018/8/28.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "AVAudioRecorderController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "AVAudioPlayerViewController.h"
@interface AVAudioRecorderController ()<AVAudioRecorderDelegate>
@property (weak, nonatomic) IBOutlet UILabel *powerLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageLabel;
@property (weak, nonatomic) IBOutlet UILabel *recoderTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIButton *startRecoderButton;
@property (weak, nonatomic) IBOutlet UIButton *stopRecorder;
@property (weak, nonatomic) IBOutlet UIButton *playerButton;

@property(nonatomic,strong)dispatch_source_t timer;
@property(nonatomic,strong)AVAudioRecorder *avAudioRecorder;
@property(nonatomic,strong)NSString *filePath;
@property(nonatomic,strong)NSURL *destURL;
@end

@implementation AVAudioRecorderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    NSError *sessionError;
    if (![session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError]) {
        NSLog(@"Category Error : %@",[sessionError localizedDescription]);
    }
    if (![session setActive:YES error:&sessionError]) {
        NSLog(@"Activation Error:%@",[sessionError localizedDescription]);
    }
    
    self.stateLabel.text = @"准备录制";
    self.stateLabel.textColor = [UIColor blueColor];
    [self.startRecoderButton addTarget:self action:@selector(startRecoder) forControlEvents:UIControlEventTouchUpInside];
    [self.stopRecorder addTarget:self action:@selector(stopRecoder) forControlEvents:UIControlEventTouchUpInside];
    //录制的音频路径
    _filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"memo.caf"];
    
    //这个设置的字典在写AVAssetWriter的时候也会用到
    NSDictionary *audioSettings = @{
                                    AVFormatIDKey : @(kAudioFormatAppleIMA4),
                                    AVSampleRateKey : @44100.0f,
                                    AVNumberOfChannelsKey :@1,
                                    AVEncoderAudioQualityKey : @(AVAudioQualityMedium)
                                    };
    NSError *errror;
    self.avAudioRecorder = [[AVAudioRecorder alloc]initWithURL:[NSURL fileURLWithPath:_filePath] settings:audioSettings error:&errror];
    NSParameterAssert(_avAudioRecorder);
    if (self.avAudioRecorder && !errror) {
        self.avAudioRecorder.delegate = self;
        self.avAudioRecorder.meteringEnabled = YES;
        [self.avAudioRecorder prepareToRecord];
    }else{
        NSLog(@"AVAudioRecorder初始化失败%@",errror);
    }
}

-(void)startRecoder{
    //开启定时器
    self.stateLabel.text = @"录制中";
    if(self.avAudioRecorder.isRecording){
        __block int time = 0;
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1.0*NSEC_PER_SEC, 0*NSEC_PER_SEC);
        dispatch_source_set_event_handler(_timer, ^{
            time++;
            if (time<=10) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self updatepwerAndRecorderTime:time];
                });
            }else{
                [self stopRecoder];
            }
        });
        dispatch_resume(_timer);
    }
    [self.avAudioRecorder record];
}

-(void)stopRecoder{
    dispatch_source_cancel(_timer);
    [self.avAudioRecorder stop];
    self.stateLabel.text = @"录制结束";
    self.stateLabel.textColor = [UIColor redColor];
    [self saveRecordingWithName:@"TESTAUDIO" completionHandler:^(BOOL save, id error) {
        if (save == YES && !error) {
            NSLog(@"音视频保存成功");
        }else{
            NSLog(@"音视频保存失败");
        }
    }];
}
-(void)saveRecordingWithName:(NSString*)name completionHandler:(THRecordingSaveCompletionHandler)handler{
    NSTimeInterval timetamp = [NSDate timeIntervalSinceReferenceDate];
    NSString *filename = [NSString stringWithFormat:@"%@-%f.m4a",name,timetamp];
    NSString *docsDir = [self DocumentsDriectory];
    NSString *destPath = [docsDir stringByAppendingPathComponent:filename];
    
    NSURL *srcUrl = self.avAudioRecorder.url;
    NSURL *destUrl = [NSURL fileURLWithPath:destPath];
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] copyItemAtURL:srcUrl toURL:destUrl error:&error];
    if (success) {
        _destURL = destUrl;
        handler(YES,error);
        [self.avAudioRecorder prepareToRecord];
    }else{
        handler(NO,error);
    }
}

-(NSString*)DocumentsDriectory{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES).firstObject;
}

#pragma  mark 更新UI
-(void)updatepwerAndRecorderTime:(int)time{
    self.recoderTimeLabel.text = [NSString stringWithFormat:@" %d 秒",time];
    [self.avAudioRecorder updateMeters];//更新测量量
    float averagePower = [self.avAudioRecorder averagePowerForChannel:0];
    float peakPower = [self.avAudioRecorder peakPowerForChannel:0];
    
    self.powerLabel.text = [NSString stringWithFormat:@"指定频道分贝值:%f",peakPower];
    self.averageLabel.text = [NSString stringWithFormat:@"平均分贝值:%f",averagePower];

}

#pragma mark AVAudioRecorderDelegate
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    
    NSLog(@"音频录制成功");
}


- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error{
    
    NSLog(@"音频编码发生错误");
}

#pragma mark 播放
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"AVAudioPlayerController"]) {
        
        AVAudioPlayerViewController * destination = segue.destinationViewController;
        destination.filePath = _destURL;
    }
}

@end
