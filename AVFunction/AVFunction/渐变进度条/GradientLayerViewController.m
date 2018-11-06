//
//  GradientLayerViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/27.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "GradientLayerViewController.h"


#define CGColorToNSObject(x) (__bridge id)x.CGColor
@interface GradientLayerViewController ()
@property(nonatomic)CALayer *maskLayer;
@end

@implementation GradientLayerViewController
static const CGFloat radius = 140;
static const CGFloat lineWidth = 10;
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(50, 100, 300, 300)];
    [self.view addSubview:containerView];
    //左面半边的gradientLayer，高度减掉线宽
    CAGradientLayer *leftLayer = [CAGradientLayer layer];
    leftLayer.colors = @[CGColorToNSObject([UIColor redColor]),CGColorToNSObject(randomColor),CGColorToNSObject([UIColor yellowColor])];
    leftLayer.startPoint = CGPointMake(0, 0);
    leftLayer.endPoint = CGPointMake(0, 1);
    leftLayer.frame = CGRectMake(0, lineWidth, containerView.width/2, containerView.height-2*lineWidth);
    [containerView.layer addSublayer:leftLayer];
    //右面半边的gradientLayer，高度减掉线宽
    CAGradientLayer *RightLayer = [CAGradientLayer layer];
    RightLayer.colors = @[CGColorToNSObject([UIColor redColor]),CGColorToNSObject(randomColor),CGColorToNSObject(randomColor),CGColorToNSObject([UIColor yellowColor])];
    RightLayer.startPoint = CGPointMake(0, 0);
    RightLayer.endPoint = CGPointMake(0, 1);
    RightLayer.frame = CGRectMake(containerView.width/2, lineWidth, containerView.width/2, containerView.height-2*lineWidth);
    [containerView.layer addSublayer:RightLayer];
    CALayer *topLayer = [CALayer layer];
    topLayer.frame = CGRectMake(0, 0, containerView.width, lineWidth);
    topLayer.backgroundColor = [UIColor redColor].CGColor;
    [containerView.layer addSublayer:topLayer];
    CALayer *bottomLayer = [CALayer layer];
    bottomLayer.frame = CGRectMake(0, containerView.height-lineWidth, containerView.width, lineWidth);
    bottomLayer.backgroundColor = [UIColor yellowColor].CGColor;
    [containerView.layer addSublayer:bottomLayer];
    //蒙版
    CAShapeLayer *masker = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius+lineWidth/2, radius+lineWidth/2) radius:radius startAngle:-M_PI_2 endAngle:M_PI_2*3 clockwise:YES];
    masker.path = path.CGPath;
    masker.lineWidth = lineWidth;
    masker.strokeColor = randomColor.CGColor;
    masker.fillColor = [UIColor clearColor].CGColor;
    masker.backgroundColor = [UIColor clearColor].CGColor;
    containerView.layer.mask = masker;
    self.maskLayer = masker;
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self heightGradientProgress];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath = @"strokeEnd";
    animation.duration = 2;
    animation.fromValue = @0;
    [self.maskLayer addAnimation:animation forKey:nil];
}

#pragma mark - 高光渐变进度条
-(void)heightGradientProgress{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(20, 450, 300, 20);
    layer.colors = @[CGColorToNSObject([UIColor cyanColor]),CGColorToNSObject([UIColor yellowColor]), CGColorToNSObject([UIColor cyanColor]), CGColorToNSObject([UIColor yellowColor]),CGColorToNSObject([UIColor cyanColor])];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    layer.locations = @[@-1,@-0.5,@0,@0.5,@1];
    [self.view.layer addSublayer:layer];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"locations";
    animation.duration = 2;
//    animation.fromValue = @[@-1,@-0.5,@0,@0.5,@1];
    animation.toValue = @[@0,@0.5,@1,@1.5,@2];
    animation.repeatCount = CGFLOAT_MAX;
    [layer addAnimation:animation forKey:nil];
    
    //用一个新的layer作为gradientLayer的蒙版，然后给这个蒙版添加动画
    //蒙版的内容逐渐变宽的话，gradientLayer的内容看起来几乎是逐渐变宽的效果
    CALayer *mask = [CALayer layer];
    mask.frame = layer.bounds;
    mask.backgroundColor = [UIColor redColor].CGColor;
    layer.mask = mask;
    
    CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundsAnimation.duration = 5;
    boundsAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 0, 20)];
    [mask addAnimation:boundsAnimation forKey:nil];
    
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = 5;
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(20, 10)];
    [mask addAnimation:positionAnimation forKey:nil];
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
