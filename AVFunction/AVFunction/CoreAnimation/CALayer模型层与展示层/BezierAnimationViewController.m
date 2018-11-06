//
//  BezierAnimationViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/25.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "BezierAnimationViewController.h"

@interface BezierAnimationViewController ()

@end

@implementation BezierAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self BezierAnimation];
}
-(void)BezierAnimation{
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.fillColor = [UIColor orangeColor].CGColor;
    [self.view.layer addSublayer:shapLayer];
    
    //构造fromPath
    UIBezierPath* fromPath = [UIBezierPath bezierPath];
    //从左上角开始画
    [fromPath moveToPoint:CGPointZero];
    
    //向下拉一条直线
    [fromPath addLineToPoint:CGPointMake(0, 400)];
    //向右拉一天曲线，因为向下弯的并且是从中间开始弯的，所以控制点的x是宽度的一半，y币起始点和结束点的y要大
    [fromPath addQuadCurveToPoint:CGPointMake(Screen_width, 400) controlPoint:CGPointMake(Screen_width/2, 600)];
    
    //向上拉一条直线
    [fromPath addLineToPoint:CGPointMake(Screen_width, 0)];
    //封闭路径，会从当前点想整个路径的起始点连一条线
    [fromPath closePath];
    
    
    //构造toPath
    UIBezierPath *toPath = [UIBezierPath bezierPath];
    
    [toPath moveToPoint:CGPointZero];
    [toPath addLineToPoint:CGPointMake(0, SCREEN_HEIGHT+200)];
    [toPath addQuadCurveToPoint:CGPointMake(Screen_width, SCREEN_HEIGHT+200) controlPoint:CGPointMake(Screen_width/2, SCREEN_HEIGHT)];
    [toPath addLineToPoint:CGPointMake(Screen_width, 0)];
    [toPath closePath];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = 5;
    //fromValue 应该是一个CGPathRef(因为path属性就是一个CGPathRef)它是以一个结构体指针，使用桥接把结构体指针转换成OC的对象
    animation.fromValue = (__bridge id)fromPath.CGPath;
    shapLayer.path = toPath.CGPath;
    [shapLayer addAnimation:animation forKey:nil];
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
