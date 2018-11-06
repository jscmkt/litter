//
//  KeyFrameAnimationFromUIView.m
//  AVFunction
//
//  Created by shoule on 2018/9/18.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "KeyFrameAnimationFromUIView.h"

@interface KeyFrameAnimationFromUIView (){
    UIImageView* _imageView;
}

@end

@implementation KeyFrameAnimationFromUIView

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景
    UIImage* background = [UIImage imageNamed:@"bg.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:background];
    
    //创建显示控件
    _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"blackBall"]];
    _imageView.center = CGPointMake(50, 150);
    [self.view addSubview:_imageView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //关键帧动画
    [UIView animateKeyframesWithDuration:5.0 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        //第二关键帧(准确的说第一关键帧是开始位置) ： 从0秒开始持续50%，也就是5*0.5 = 2.5秒
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
            _imageView.center = CGPointMake(80, 200);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.25 animations:^{
            
            _imageView.center = CGPointMake(40,300);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
            _imageView.center = [[touches anyObject] locationInView:self.view];
        }];
    } completion:^(BOOL finished) {
        NSLog(@"animation ended");
    }];
    /*
     options 的补充
     UIViewKeyframeAnimationOptionCalculationModeLinear：连续运算模式。
     
     UIViewKeyframeAnimationOptionCalculationModeDiscrete ：离散运算模式。
     
     UIViewKeyframeAnimationOptionCalculationModePaced：均匀执行运算模式。
     
     UIViewKeyframeAnimationOptionCalculationModeCubic：平滑运算模式。
     
     UIViewKeyframeAnimationOptionCalculationModeCubicPaced：平滑均匀运算模式。
     */
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
