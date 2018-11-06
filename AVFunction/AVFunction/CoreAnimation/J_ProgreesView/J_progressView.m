//
//  J_progressView.m
//  AVFunction
//
//  Created by shoule on 2018/9/12.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "J_progressView.h"
#import "J_ProgressLayer.h"
@interface J_progressView()

@property(nonatomic,strong)J_ProgressLayer *progressLayer;
@property(nonatomic,strong)UILabel *progressLabel;
@property(nonatomic,strong)CAShapeLayer *background;
@property(nonatomic,strong)CAShapeLayer *top;
//@property(nonatomic,strong)UIBezierPath *path;
@property(nonatomic,strong)UIBezierPath *path;

@end
@implementation J_progressView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        
    }
    return self;
}
-(void)setup{
    self.progressLayer = [J_ProgressLayer layer];
    self.progressLayer.strokeColor = RGB(66, 1, 66).CGColor;
    self.progressLayer.frame = self.bounds;
    __weak UILabel *weakLab = self.progressLabel;
    self.progressLayer.report = ^(NSInteger progress, CGRect textRect, CGColorRef textColor) {
        NSString *progressStr = [NSString stringWithFormat:@"%lu%%",progress];
        weakLab.text = progressStr;
        weakLab.frame = textRect;
        weakLab.textColor = [UIColor colorWithCGColor:textColor];
        
    };
    //分辨率
    self.progressLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:self.progressLayer];
    [self addSubview:self.progressLabel];
    
    [self.layer addSublayer:self.background];
    [self.layer addSublayer:self.top];
}
-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    self.progressLayer.strokeEnd = progress;
    self.progressLayer.progress = progress;
    [self updatePath];
    
}
-(UILabel *)progressLabel{
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _progressLabel.font = [UIFont systemFontOfSize:13.f];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _progressLabel;
}
-(CAShapeLayer *)background{
    if (!_background) {
        _background = [CAShapeLayer layer];
        _background.fillColor = [UIColor clearColor].CGColor;
        _background.strokeColor = RGB(204, 204, 204).CGColor;
        _background.lineWidth = 5.f;
        _background.lineCap = kCALineCapRound;//圆角
        _background.lineJoin = kCALineJoinRound;//转弯圆角
        
    }
    return _background;
}
- (CAShapeLayer *)top {
    if (!_top) {
        _top = [CAShapeLayer layer];
        _top.fillColor = [UIColor clearColor].CGColor;
        _top.strokeColor = [UIColor colorWithRed:66/255.f green:1.f blue:66/255.f alpha:1.f].CGColor;
        _top.lineCap = kCALineCapRound;
        _top.lineJoin = kCALineJoinRound;
        _top.lineWidth = 5.f;
    }
    return _top;
}
-(UIBezierPath *)path{
    if (!_path) {
        _path = [UIBezierPath bezierPath];
    }
    return _path;
}
-(void)updatePath{
//    UIBezierPath *path = [UIBezierPath bezierPath];
    [self.path removeAllPoints];
    [self.path moveToPoint:CGPointMake(25, 150)];
    [self.path addLineToPoint:CGPointMake((CGRectGetWidth([UIScreen mainScreen].bounds)-50)*_progress+25, 150+(25.f*(1-fabs(_progress-0.5)*2)))];
    [self.path addLineToPoint:CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds)-25, 150)];
    self.background.path = self.path.CGPath;
    self.top.path = self.path.CGPath;
    self.top.strokeEnd = _progress;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
