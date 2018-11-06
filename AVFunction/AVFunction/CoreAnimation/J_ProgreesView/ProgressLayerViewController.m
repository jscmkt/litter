//
//  ProgressLayerViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/12.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "ProgressLayerViewController.h"
#import "J_progressView.h"
@interface ProgressLayerViewController ()

@property (strong, nonatomic)  UIView *TimeOffsetAndSpeedView;
@property (nonatomic, strong) J_progressView *progressView;

@end

@implementation ProgressLayerViewController
-(void)backPresent{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(20, 40, 50, 20);
    [backBtn setTitle:@"back" forState:(UIControlStateNormal)];
    [backBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(backPresent) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
    self.view.backgroundColor = [UIColor whiteColor];
    self.progressView = [[J_progressView alloc]initWithFrame:CGRectMake(0, 80, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame))];
    self.progressView.progress = 0.f;
    self.progressView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.progressView];
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(12, SCREEN_HEIGHT-50-30, SCREEN_WIDTH-24, 30)];
    [slider addTarget:self action:@selector(changeProgress:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:slider];
    [self.view addSubview:self.TimeOffsetAndSpeedView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    CABasicAnimation* changeColor = [CABasicAnimation animation];
    changeColor.keyPath = @"backgroundColor";
    changeColor.toValue = (__bridge id _Nullable)([UIColor orangeColor].CGColor);
    changeColor.fromValue = (__bridge id _Nullable)([UIColor greenColor].CGColor);
    changeColor.duration = 1.0;
    self.TimeOffsetAndSpeedView.layer.speed = 0;
    [self.TimeOffsetAndSpeedView.layer addAnimation:changeColor forKey:@"changecolor"];
}


- (void)changeProgress:(UISlider*)sender {
    self.progressView.progress = sender.value;
    self.TimeOffsetAndSpeedView.layer.timeOffset = sender.value;
    
}



-(UIView *)TimeOffsetAndSpeedView{
    if (!_TimeOffsetAndSpeedView) {
        
        _TimeOffsetAndSpeedView = [[UIView alloc]initWithFrame:CGRectMake(12, SCREEN_HEIGHT-80-20-50, SCREEN_WIDTH-24, 50)];
        _TimeOffsetAndSpeedView.backgroundColor = [UIColor redColor];
    }
    return _TimeOffsetAndSpeedView;
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
