//
//  mediaPlayController.m
//  AVFunction
//
//  Created by shoule on 2018/8/24.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "mediaPlayController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface mediaPlayController ()
@property(nonatomic,strong) AVPlayerItem *avPlayerItem;
@property(nonatomic,strong) AVPlayer *avPlayer;
@property(nonatomic,strong) AVPlayerLayer *avPlayerLayer;
@property(nonatomic,strong) AVPlayerViewController *controller;
@property (weak, nonatomic) IBOutlet UILabel *videoDuration;
@property (weak, nonatomic) IBOutlet UILabel *videoPlayerTime;
@property (weak, nonatomic) IBOutlet UILabel *cacheProcessTime;


@end

@implementation mediaPlayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.avPlayerItem = [AVPlayerItem playerItemWithURL:self.MovieURL];
    self.avPlayer = [[AVPlayer alloc]initWithPlayerItem:self.avPlayerItem];
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    self.avPlayerLayer.frame = CGRectMake(10, 100, 355, 200);
    [self.view.layer addSublayer:self.avPlayerLayer];
    //添加观察者
    [self addObserverWithAVPlayerItem];
}
#pragma mark KVO
-(void)addObserverWithAVPlayerItem{
    //状态添加观察者
    [self.avPlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //缓存进度添加观察者
    [self.avPlayerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:(NSKeyValueObservingOptionNew) context:nil];
    __weak typeof(self) WSELF = self;
    //用于更新播放的进度条  Periodic周期
    [WSELF.avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 10) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        // CMTimeMake(1, 10) 十分之一秒
        // CMTime的timescale 的定义帮助理解下面代码
        // @field timescale The timescale of the CMTime. value/timescale = seconds.
        float currentPlayTime = (double)self.avPlayerItem.currentTime.value/self.avPlayerItem.currentTime.timescale;
        NSLog(@"当前播放进度：%f",currentPlayTime);
        WSELF.videoPlayerTime.text = [NSString stringWithFormat:@"播放进度：%f",currentPlayTime];
    }];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    AVPlayerItem *avplayeritem = (AVPlayerItem*)object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        if (status == AVPlayerStatusReadyToPlay) {
            NSLog(@"准备好了");
            CMTime duration = avplayeritem.duration;
            NSLog(@"视频总时长:%.2f",CMTimeGetSeconds(duration));
            self.videoDuration.text = [NSString stringWithFormat:@"视频总时长：%.2f",CMTimeGetSeconds(duration)];
            // 播放
            [self.avPlayer play];
        }else if (status == AVPlayerStatusFailed){
            
            NSLog(@"视频准备发生错误");
            NSError * error = avplayeritem.error;
            NSLog(@"视频准备发生错误:%@",error);
        }else{
            
            NSLog(@"位置错误");
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        //可以自定义缓存进度
        NSTimeInterval timeInterval = [self alreadyCacheVideoProgress];
        NSLog(@"视频已经缓存的时长:%.2f",timeInterval);
        
        self.cacheProcessTime.text  = [NSString stringWithFormat:@"缓存进度：%.2f",timeInterval];
        
    }
}
#pragma mark 缓存进度
-(NSTimeInterval)alreadyCacheVideoProgress{
    //现货区到它的缓存的进度
    NSArray * cacheVideoTime = [self.avPlayerItem loadedTimeRanges];
    //CMTimeRanges 结构体 start duration 表示其实位置 和持续时间
    // 获取缓冲区域
    CMTimeRange timeRanges = [cacheVideoTime.firstObject CMTimeRangeValue];
    float startSeconds = CMTimeGetSeconds(timeRanges.start);
    float durationSeconds = CMTimeGetSeconds(timeRanges.duration);
    
    NSLog(@"startSeconds= %f  durationSeconds = %f",startSeconds,durationSeconds);
    // 计算总缓冲时间 = start + duration
    NSTimeInterval result = startSeconds + durationSeconds;
    return result;
}

-(void)dealloc{
    
    [self.avPlayerItem removeObserver:self forKeyPath:@"status"];
    [self.avPlayerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}
@end
