//
//  FlowViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/13.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "FlowViewController.h"
#import "J_ActivituIndicator.h"
@interface FlowViewController ()
@property (weak, nonatomic) IBOutlet J_ActivituIndicator *loadingIndicator;
@property (nonatomic, strong) CAShapeLayer *maskLayerUp;
@property (nonatomic, strong) CAShapeLayer *maskLayerDown;
@property (nonatomic, weak) IBOutlet UIImageView *grayHead;
@property (nonatomic, weak) IBOutlet UIImageView *greenHead;

@end

@implementation FlowViewController
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
    self.greenHead.layer.mask = [self greenHeadMaskLayer];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.loadingIndicator startAnimation];
    [self startGreenHeadAimation];
}
-(CALayer*)greenHeadMaskLayer{
    CALayer *mask = [CALayer layer];
    mask.frame = self.greenHead.bounds;
    self.maskLayerUp = [CAShapeLayer layer];
    self.maskLayerUp.bounds = CGRectMake(0, 0, 60.0f, 60.0f);
    self.maskLayerUp.fillColor = [UIColor greenColor].CGColor;
    self.maskLayerUp.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(30, 30) radius:30 startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath;
    
    self.maskLayerUp.opacity = 0.8f;
    self.maskLayerUp.position = CGPointMake(-5.0f, -5.0f);
    [mask addSublayer:self.maskLayerUp];
    
    self.maskLayerDown = [CAShapeLayer layer];
    self.maskLayerDown.bounds = CGRectMake(0, 0, 60.f,60.f);
    self.maskLayerDown.fillColor = [UIColor greenColor].CGColor;
    self.maskLayerDown.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(30.0, 30.0) radius:30.0 startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath;
    self.maskLayerDown.position = CGPointMake(65.f, 65.f);
    [mask addSublayer:self.maskLayerDown];
    return mask;
}
-(void)startGreenHeadAimation{
    CABasicAnimation *animationDown = [CABasicAnimation animationWithKeyPath:@"position"];
    animationDown.fromValue = [NSValue valueWithCGPoint:CGPointMake(-5.0f, -5.0f)];
    animationDown.toValue = [NSValue valueWithCGPoint:CGPointMake(25.0f, 25.0f)];
    animationDown.duration = 1;
    animationDown.repeatCount = MAXFLOAT;
    [self.maskLayerUp addAnimation:animationDown forKey:@"downAnimation"];
    
    CABasicAnimation* animationUp = [CABasicAnimation animationWithKeyPath:@"position"];
    animationUp.fromValue = [NSValue valueWithCGPoint:CGPointMake(65.f, 65.f)];
    animationUp.toValue = [NSValue valueWithCGPoint:CGPointMake(35.f, 35.f)];
    animationUp.duration = 1;
    animationUp.repeatCount = MAXFLOAT;
    [self.maskLayerDown addAnimation:animationUp forKey:@"upAnimation"];
}
@end
