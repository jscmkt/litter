//
//  WriteViewController.m
//  AVFunction
//
//  Created by shoule on 2018/8/23.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "WriteViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface WriteViewController ()

@end

@implementation WriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)speakMessage:(id)sender {
    AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc]init];
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"做准备好了，开始录制"];
    utterance.rate = 0;//播放速率 默认1.0
    utterance.voice = voice;
    utterance.pitchMultiplier = 0.8;  //可在播放待定语句时候改变声调
    utterance.postUtteranceDelay = 0.1;//语音合成器在播放下一句的时候有短暂的停顿 这个属性指定停顿的时间
    [synthesizer speakUtterance:utterance];
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
