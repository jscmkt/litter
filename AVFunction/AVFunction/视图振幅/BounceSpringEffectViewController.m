//
//  BounceSpringEffectViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/29.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "BounceSpringEffectViewController.h"

@interface BounceSpringEffectViewController (){
    //contentsFrame基于animationView坐标系的frame
    CGRect _privateContentsFrame;
}
@property(nonatomic,strong)CAShapeLayer *maskLayer;
@property(nonatomic,strong)CADisplayLink *displayLink;

@property(nonatomic,strong)UIView *topControlPointView;
@property(nonatomic,strong)UIView *leftControlPointView;
@property(nonatomic,strong)UIView *bottomControlPointView;
@property(nonatomic,strong)UIView *rightControlPointView;

//振幅
@property(nonatomic,assign)CGFloat amplitude;

@property(nonatomic,assign)CGRect contentsFrame;

//用来做动画效果测试的视图
@property(nonatomic,strong)UIControl *animationView;
@end

@implementation BounceSpringEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initalizeDataSource];
    [self initializeAppearance];
    
}
#pragma mark - callback
-(void)touchDown{
    //按下，执行控制点的膨胀动画，也就是把控制点移到振幅的位置
    //同时开启displayLink，因为按下的一瞬间就应该开启监听控制点的位置改变了
    if (!self.displayLink.paused) {
        return;
    }
    [self startDisplayLink];
    [self prepareForBounceAnimation];
}
-(void)touchUp{
    //放开，执行控制点的弹性动画，
    [self bounceWithAnimation];
    
}
-(void)onDisplayLink{
    //无论是按下还是放开，只要改变了控制点的位置，就应该根据最新的控制点重绘四条边的形状
    //调用pathForMaskLayer来计算最新的path并复制给蒙版layer
    self.maskLayer.path = [self pathForMaskLayer];
}
#pragma mark - private methods
-(void)prepareForBounceAnimation{
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:1.5 options:0 animations:^{
        
        self.topControlPointView.frame = CGRectOffset(self.topControlPointView.frame, 0, -self.amplitude);
        self.leftControlPointView.frame = CGRectOffset(self.leftControlPointView.frame, -self.amplitude, 0);
        self.bottomControlPointView.frame = CGRectOffset(self.bottomControlPointView.frame, 0, self.amplitude);
        self.rightControlPointView.frame = CGRectOffset(self.rightControlPointView.frame, self.amplitude, 0);
        
    } completion:^(BOOL finished) {
        
    }];
    
}
-(void)bounceWithAnimation{
    
    [UIView animateWithDuration:0.45 delay:0 usingSpringWithDamping:0.15 initialSpringVelocity:5.5 options:0 animations:^{
        [self positionControlPoints];
    } completion:^(BOOL finished) {
        [self stopDisplayLink];
    }];
    
}
-(void)startDisplayLink{
    self.displayLink.paused = NO;
}
-(void)stopDisplayLink{
    self.displayLink.paused = YES;
}
-(CGPathRef)pathForMaskLayer{
    //视图课件部分的宽和高
    CGFloat width = CGRectGetWidth(self.contentsFrame);
    CGFloat height = CGRectGetHeight(self.contentsFrame);
    //获取四个控制点，这里通过四个控制点视图的presentationLayer来获取
    CGPoint topControlPoint = CGPointMake(width/2, [self.topControlPointView.layer.presentationLayer position].y - self.amplitude);
    
    CGPoint rightControlPoint = CGPointMake([self.rightControlPointView.layer.presentationLayer position].x - self.amplitude,height/2);
    
    CGPoint bottomControlPoint = CGPointMake(width/2, [self.bottomControlPointView.layer.presentationLayer position].y - self.amplitude);
    
    CGPoint leftControlPoint = CGPointMake([self.leftControlPointView.layer.presentationLayer position].x - self.amplitude,height/2);
    
    //为一个UIBezierPath对象添加四条二阶贝塞尔曲线
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointZero];
    [bezierPath addQuadCurveToPoint:CGPointMake(width, 0) controlPoint:topControlPoint];
    [bezierPath addQuadCurveToPoint:CGPointMake(width, height) controlPoint:rightControlPoint];
    [bezierPath addQuadCurveToPoint:CGPointMake(0, height) controlPoint:bottomControlPoint];
    [bezierPath addQuadCurveToPoint:CGPointZero controlPoint:leftControlPoint];
    return bezierPath.CGPath;
    
    
    
}
/** 通过contentsFrame和interval确定自己的frame*/
-(void)updateFrame{
    CGFloat x = self.contentsFrame.origin.x - self.amplitude;
    CGFloat y = self.contentsFrame.origin.y - self.amplitude;
    CGFloat width = self.contentsFrame.size.width + 2 *self.amplitude;
    CGFloat height = self.contentsFrame.size.height +2 * self.amplitude;
    self.animationView.frame = CGRectMake(x, y, width, height);
    
    _privateContentsFrame = CGRectMake(self.amplitude, self.amplitude, CGRectGetWidth(self.contentsFrame), CGRectGetHeight(self.contentsFrame));
    self.maskLayer.frame = _privateContentsFrame;
}

-(void)initalizeDataSource{
    self.contentsFrame = CGRectMake(80, 80, 200, 80);
    self.amplitude = 15;
}
#pragma  mark - 初始化视图
-(void)initializeAppearance{
    [self updateFrame];
    [self.view addSubview:self.animationView];
    for (UIView *view in @[self.topControlPointView,self.leftControlPointView,self.bottomControlPointView,self.rightControlPointView]) {
        view.frame = CGRectMake(0, 0, 5, 5);
        [self.animationView addSubview:view];
    }
    [self positionControlPoints];
    self.animationView.layer.mask = self.maskLayer;
}

/** 把四个控制点还原到起始位置(在初始化的时候也要调用，让他们一开始就在起始位置) */
-(void)positionControlPoints{
    
    self.topControlPointView.center = CGPointMake(CGRectGetMidX(self.animationView.bounds), self.amplitude);
    
    self.leftControlPointView.center = CGPointMake(self.amplitude, CGRectGetMidY(self.animationView.bounds));
    
    self.bottomControlPointView.center = CGPointMake(CGRectGetMidX(self.animationView.bounds), CGRectGetHeight(self.animationView.bounds) - self.amplitude);
    
    self.rightControlPointView.center = CGPointMake(CGRectGetWidth(self.animationView.bounds) - self.amplitude, CGRectGetMidY(self.animationView.bounds));
    
}

#pragma  mark - getter

- (UIView *)topControlPointView
{
    if (!_topControlPointView) {
        _topControlPointView = [[UIView alloc] init];
    }
    return _topControlPointView;
}


- (UIView *)leftControlPointView
{
    if (!_leftControlPointView) {
        _leftControlPointView = [[UIView alloc] init];
    }
    return _leftControlPointView;
}

- (UIView *)bottomControlPointView
{
    if (!_bottomControlPointView) {
        _bottomControlPointView = [[UIView alloc] init];
    }
    return _bottomControlPointView;
}

- (UIView *)rightControlPointView
{
    if (!_rightControlPointView) {
        _rightControlPointView = [[UIView alloc] init];
    }
    return _rightControlPointView;
}
-(UIControl *)animationView{
    if (!_animationView) {
        _animationView = ({
            UIControl *view = [[UIControl alloc]initWithFrame:CGRectMake(80, 80, 200, 80)];
            view.backgroundColor = [UIColor blackColor];
            [view addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
            [view addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpInside];
            
            // 用户按下后发生手势响应中断的情况，比如按下后还没放开呢，突然来了个电话。
            [view addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchCancel];
            // 用户按下后，保持按住的状态把手指移到视图外部再放开的情况
            [view addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpOutside];
            
            
            view;
        });
    }
    return _animationView;
}
-(CAShapeLayer *)maskLayer{
    if (!_maskLayer) {
        _maskLayer = ({
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.fillColor = [UIColor redColor].CGColor;
            layer.backgroundColor = [UIColor clearColor].CGColor;
            layer.strokeColor = [UIColor clearColor].CGColor;
            layer.frame = _privateContentsFrame;
            layer.path = [UIBezierPath bezierPathWithRect:layer.bounds].CGPath;
            layer;
        });
    }
    return _maskLayer;
}

-(CADisplayLink *)displayLink{
    if (!_displayLink) {
        _displayLink = ({
            CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(onDisplayLink)];
            displayLink.paused = YES;
            [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
            
            displayLink;
        });
    }
    return _displayLink;
}

@end
