//
//  KeyFrameAnimationViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/17.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "KeyFrameAnimationViewController.h"

@interface KeyFrameAnimationViewController ()
@property(nonatomic,strong)CALayer *layer;
@end

@implementation KeyFrameAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景（注意这个图片其实在根图层）
    UIImage* backgroundImage = [UIImage imageNamed:@"bg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    //自定义一个图层
    self.layer = [[CALayer alloc]init];
    self.layer.bounds= CGRectMake(0, 0, 10, 20);
    self.layer.position = CGPointMake(50, 150);
    self.layer.contents = (id)[UIImage imageNamed:@"雪"].CGImage;
    [self.view.layer addSublayer:self.layer];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //创建动画
    [self translationAnimation_path];
}
//关键帧动画开发分为两种形式：一种是通过设置不同的属性值进行关键帧控制，另一种是通过绘制路径进行关键帧控制。后者优先级高于前者，如果设置了路径则属性值就不再起作用。
-(void)translationAnimation_path{
    CAKeyframeAnimation *keyFrameAniamtion = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //2.设置路径
    //贝塞尔曲线
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.layer.position.x, self.layer.position.y);
    CGPathAddCurveToPoint(path, NULL, 160, 200, -30,300, 55, 400);//绘制三次贝塞尔曲线
    keyFrameAniamtion.path = path;
    CGPathRelease(path);//手动销毁
    
    keyFrameAniamtion.duration = 5.0;
    keyFrameAniamtion.beginTime = CACurrentMediaTime() + 2;//设置延迟2秒执行
    
    //添加动画到图层，添加动画后就会执行动画
    [self.layer addAnimation:keyFrameAniamtion forKey:@"myAnimation"];
    
    
    
}
-(void)translationAnimation_values{
    //1.1创建关键帧动画并设置动画属性
    CAKeyframeAnimation * keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //2.设置关键帧，这里有四个关键帧
    NSValue * key1 = [NSValue valueWithCGPoint:self.layer.position];//对于关键帧动画初始值不能省略
    
    NSValue* key2 = [NSValue valueWithCGPoint:CGPointMake(80, 220)];
    NSValue* key3 = [NSValue valueWithCGPoint:CGPointMake(45, 320)];
    NSValue* key4 = [NSValue valueWithCGPoint:CGPointMake(75, 420)];
    //设置其他属性
    keyFrameAnimation.values = @[key1,key2,key3,key4];
    keyFrameAnimation.duration = 7;
    //keyFrameAnimation.beginTime = CACurrentMediaTime() + 2;//设置延迟2秒执行
    keyFrameAnimation.keyTimes = @[@(2/7.0),@(5.5/7),@(6.25/7),@1.0];
    //3.添加动画到图层，添加动画后就会行动画
    [self.layer addAnimation:keyFrameAnimation forKey:@"myAnimation"];
}

@end
