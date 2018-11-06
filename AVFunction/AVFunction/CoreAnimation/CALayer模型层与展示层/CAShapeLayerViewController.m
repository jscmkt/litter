//
//  CAShapeLayerViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/21.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "CAShapeLayerViewController.h"

@interface CAShapeLayerViewController ()

@end

@implementation CAShapeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sinXhelfHeight];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self strokeStartAnimation];
    
}
#pragma strokrStart动画
-(void)strokeStartAnimation{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = randomColor.CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    [self.view.layer addSublayer:shapeLayer];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 300) radius:100 startAngle:M_PI_2 endAngle:0 clockwise:YES];
    shapeLayer.path = path.CGPath;
    //添加动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"storkeStart"];
    animation.duration = 3;
    animation.fromValue = @0;
    //直接修改modelLayer的属性来代替toValue
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        shapeLayer.strokeStart = 1;
        [shapeLayer addAnimation:animation forKey:nil];
    });
}
#pragma mark - 正sin曲线
-(void)sinXhelfHeight{
    
    //使用一个shapeLayer来显示函数图像
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = randomColor.CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    //后遭函数图像
    CGFloat width = self.view.width;
    CGFloat height = self.view.height;
    //先构造一个空的路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    //第一个点需要moveToPoint，所以放到for循环之前来
    //当x = 0 的时候sinx = 0；
    [path moveToPoint:CGPointMake(0, height/2)];
    for (int i=1; i<width; i++) {
        //对sinx图像进行变形
        CGFloat y = height/2 *sin(2*M_PI*i/100)+height/2;
        //解决坐标轴方向相反的问题
        CGPoint point = CGPointMake(i, height-y);
        [path addLineToPoint:point];
        
    }
    shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:shapeLayer];
    
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
