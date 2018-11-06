//
//  AVAudioPlayerViewController.m
//  AVFunction
//
//  Created by shoule on 2018/8/23.
//  Copyright © 2018年 WT. All rights reserved.
//
/*
 
 AVAudioPlayer 基本方法以及属性
 
 基本的初始化方法
 - (nullable instancetype)initWithContentsOfURL:(NSURL *)url error:(NSError **)outError;
 - (nullable instancetype)initWithData:(NSData *)data error:(NSError **)outError;
 - (nullable instancetype)initWithContentsOfURL:(NSURL *)url fileTypeHint:(NSString * __nullable)utiString error:(NSError **)outError NS_AVAILABLE(10_9, 7_0);
 - (nullable instancetype)initWithData:(NSData *)data fileTypeHint:(NSString * __nullable)utiString error:(NSError **)outError NS_AVAILABLE(10_9, 7_0);
 
 // 准备播放，这个方法可以不执行，但执行的话可以降低播放器play方法和你听到声音之间的延时
 - (BOOL)prepareToPlay;
 
 // 播放
 - (BOOL)play;
 // play a sound some time in the future. time is an absolute time based on and greater than deviceCurrentTime.
 // 跳转到某一个时间点播放
 - (BOOL)playAtTime:(NSTimeInterval)time NS_AVAILABLE(10_7, 4_0);
 // 暂停 pauses  playback, but remains ready to play
 - (void)pause;
 // 停止
 // 它和上面的暂停的方法是在底层stop会撤销掉prepareToPlay时所作的设置，但是调用暂停不会
 - (void)stop;
 
 
 properties
 // 是否在播放
 @property(readonly, getter=isPlaying) BOOL playing
 // 音频声道数，只读
 @property(readonly) NSUInteger numberOfChannels
 // 音长
 @property(readonly) NSTimeInterval duration
 
 //the delegate will be sent messages from the AVAudioPlayerDelegate protocol
 @property(assign, nullable) id<AVAudioPlayerDelegate> delegate;
 
 // 下面两个是获取到的你初始化传入的相应的值
 @property(readonly, nullable) NSURL *url
 @property(readonly, nullable) NSData *data
 
 // set panning. -1.0 is left, 0.0 is center, 1.0 is right. NS_AVAILABLE(10_7, 4_0)
 // 允许使用立体声播放声音 如果为-1.0则完全左声道，如果0.0则左右声道平衡，如果为1.0则完全为右声道
 @property float pan
 
 // 音量 The volume for the sound. The nominal range is from 0.0 to 1.0.
 @property float volume
 
 // set音量逐渐减弱在时间间隔内
 - (void)setVolume:(float)volume fadeDuration:(NSTimeInterval)duration NS_AVAILABLE(10_12, 10_0);
 
 // 是否能设置rate属性，只有这个属性设置成YES了才能设置rate属性，并且这些属性都设置在prepareToPlay方法调用之前
 @property BOOL enableRate NS_AVAILABLE(10_8, 5_0);
 @property float rate NS_AVAILABLE(10_8, 5_0);
 
 // 当前播放的时间，利用定时器去观察这个属性可以读取到音频播放的时间点
 需要注意的是这个时间在你暂停播放之后是不会再改变的
 @property NSTimeInterval currentTime;
 
 // 输出设备播放音频的时间，注意如果播放中被暂停此时间也会继续累加
 @property(readonly) NSTimeInterval deviceCurrentTime NS_AVAILABLE(10_7, 4_0);
 
 // 这个属性实现循环播放， 设置一个大于0的数值，可以实现循环播放N次，要是设置-1，就会无限的循环播放
 @property NSInteger numberOfLoops;
 
 // 音频播放设置信息，只读
 @property(readonly) NSDictionary<NSString *, id> *settings NS_AVAILABLE(10_7, 4_0);
 
 // 10.0之后的属性，注意是只读
 @property(readonly) AVAudioFormat * format NS_AVAILABLE(10_12, 10_0);
 @property(getter=isMeteringEnabled) BOOL meteringEnabled;
 
 // 更新音频测量值，注意如果要更新音频测量值必须设置meteringEnabled为YES，
 通过音频测量值可以即时获得音频分贝等信息
 - (void)updateMeters
 
 // 获得指定声道的分贝峰值，注意如果要获得分贝峰值必须在此之前调用updateMeters方法
 - (float)peakPowerForChannel:(NSUInteger)channelNumber
 
 // 获得指定声道的分贝平均值，注意如果要获得分贝平均值必须在此之前调用updateMeters方法
 - (float)averagePowerForChannel:(NSUInteger)channelNumber
 
 @property(nonatomic, copy, nullable) NSArray<AVAudioSessionChannelDescription *> *channelAssignments
 
 
 AVAudioPlayerDelegate 播放代理
 @optional
 
 // 成功播放到结束
 - (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;
 
 // if an error occurs while decoding it will be reported to the delegate.
 // 看上面的解释在音频解码出错的时候就会走这个方法
 - (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error;
 
 
 // 注意下面的一行解释，下面的代理方法在8.0之后被弃用了，转用AVAudioSession来代替了
 AVAudioPlayer INTERRUPTION NOTIFICATIONS ARE DEPRECATED - Use AVAudioSession instead.
 
 // audioPlayerBeginInterruption: is called when the audio session has been interrupted while the player was playing. The player will have been paused.
 // Interruption 中断 声音播放被中断的时候就会进这个代理方法
 - (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player NS_DEPRECATED_IOS(2_2, 8_0);
 
 // audioPlayerEndInterruption:withOptions: is called when the audio session interruption has ended and this player had been interrupted while playing.
 // 中断结束进这里代理
 - (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags NS_DEPRECATED_IOS(6_0, 8_0);
 
 - (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withFlags:(NSUInteger)flags NS_DEPRECATED_IOS(4_0, 6_0);
 
 // audioPlayerEndInterruption: is called when the preferred method, audioPlayerEndInterruption:withFlags:, is not implemented.
 - (void)audioPlayerEndInterruption:(AVAudioPlayer *)player NS_DEPRECATED_IOS(2_2, 6_0);
 
 */
#import "AVAudioPlayerViewController.h"
#include <AVFoundation/AVFoundation.h>
@interface AVAudioPlayerViewController ()<AVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *fileAudioPlayer;
@property (weak, nonatomic) IBOutlet UIButton *urlAudioPlayer;
@property (weak, nonatomic) IBOutlet UIProgressView *processView;
@property (weak, nonatomic) IBOutlet UILabel *peakPowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *averagePowerLabel;

//一个能让我们以和屏幕刷新率相同的频率将内容画到屏幕上的定时器
@property(nonatomic,strong)CADisplayLink *cadisplayerLink;
@property(nonatomic,strong)AVAudioPlayer *avAdioPlayer;

@property(nonatomic,assign)BOOL isPlay;
@end

@implementation AVAudioPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    //设置为背景乐
    if (![session setCategory:AVAudioSessionCategoryPlayback error:&sessionError]) {
        NSLog(@"CateGory Error:%@",[sessionError localizedDescription]);
    }
    //激活
    if(![session setActive:YES error:&sessionError  ]){
        NSLog(@"CateGory Error:%@",[sessionError localizedDescription]);
        
    }
    [self.fileAudioPlayer addTarget:self action:@selector(playerFileAudio) forControlEvents:(UIControlEventTouchUpInside)];
    [self.urlAudioPlayer addTarget:self action:@selector(playerAudioPower) forControlEvents:(UIControlEventTouchUpInside)];
    
    NSURL *urlPath;
    NSError *fileError;
    
    if (self.filePath) {
        urlPath = self.filePath;
    }else{
        urlPath = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"薛之谦-像风一样.mp3" ofType:nil]];
    }
    
    _avAdioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:urlPath error:&fileError];
    _avAdioPlayer.delegate = self;
    NSParameterAssert(_avAdioPlayer);
    if (!fileError) {
        
        NSLog(@"本地音频初始化成功！");
        NSLog(@"本地音频的时长为:%f",_avAdioPlayer.duration);
        
    }else{
        
        NSLog(@"初始化成失败%@",fileError);
    }
    if (_avAdioPlayer && fileError == nil) {
        _avAdioPlayer.enableRate = YES;//速率
        // 允许使用立体声播放声音 如果为-1.0则完全左声道，如果0.0则左右声道平衡，如果为1.0则完全为右声道
        _avAdioPlayer.pan = 0;
        // 更新音频测量值，注意如果要更新音频测量值必须设置meteringEnabled为YES，通过音频测量值可以即时获得音频分贝等信息
        _avAdioPlayer.meteringEnabled = YES;
        _avAdioPlayer.numberOfLoops = -1;
        //准备播放,可以减少延迟
        [_avAdioPlayer prepareToPlay];
        
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    }
    
}
#pragma mark 播放本地音乐
-(void)playerFileAudio{
    _isPlay = (_isPlay == NO) ? YES:NO;
    if (_avAdioPlayer && _isPlay == YES) {
        [_avAdioPlayer play];
        if ([_avAdioPlayer isPlaying]) {
            [self.fileAudioPlayer setTitle:@"暂停播放" forState:(UIControlStateNormal)];
            [self cadisplayerLinkStartPlayAudio];//更新进度
        }
    }else if(_avAdioPlayer && _isPlay==NO && [_avAdioPlayer isPlaying]){
        
        [self.fileAudioPlayer setTitle:@"继续播放" forState:(UIControlStateNormal)];
        [_avAdioPlayer pause];
    }
}



#pragma mark 获取分贝值
-(void)playerAudioPower{
    [self.avAdioPlayer updateMeters];// 更新音频测量值，注意如果要更新音频测量值必须设置meteringEnabled为YES，通过音频测量值可以即时获得音频分贝等信息
    float peakPower = [self.avAdioPlayer peakPowerForChannel:1];
    float averagePower = [self.avAdioPlayer averagePowerForChannel:1];
    self.peakPowerLabel.text = [NSString stringWithFormat:@"指定频道分贝值：%f ",peakPower];
    self.averagePowerLabel.text = [NSString stringWithFormat:@"平均分贝值：%f ",averagePower];
}

#pragma mark 更新播放进度
-(void)updataProcess{
    
    NSLog(@"_avAudioPlayer:%f",_avAdioPlayer.currentTime);
    NSLog(@"_avAudioPlayer:%f",_avAdioPlayer.deviceCurrentTime);//设备播放音频的时间，注意如果播放中被暂停此时间也会继续累加
    self.processView.progress = self.avAdioPlayer.currentTime/self.avAdioPlayer.duration;
}


#pragma mark AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    NSLog(@"播放结束");
}

-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
    
    NSLog(@"解码出错");
}
#pragma mark 开始播放音频
-(void)cadisplayerLinkStartPlayAudio{
    if (!_cadisplayerLink) {
        _cadisplayerLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updataProcess)];
        [_cadisplayerLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}
-(void)dealloc{
    NSLog(@"dealloc:%d",_avAdioPlayer.isPlaying);
    [_cadisplayerLink invalidate];
    if (_avAdioPlayer.isPlaying) {
        [_avAdioPlayer stop];
    }
    _avAdioPlayer = nil;
    
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
