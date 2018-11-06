//
//  J_ProgressLayer.m
//  AVFunction
//
//  Created by shoule on 2018/9/12.
//  Copyright © 2018年 WT. All rights reserved.
//

#define MAX_LENGTH (CGRectGetWidth([UIScreen mainScreen].bounds) - 50)
#import "J_ProgressLayer.h"
@interface J_ProgressLayer()
@property(nonatomic,assign) CGPoint origin;
@property(nonatomic,assign)CGRect textRext;
@property(nonatomic,assign)CGFloat maxOffset;
@end
@implementation J_ProgressLayer
-(instancetype)init{
    if (self = [super init]) {
        self.origin = CGPointMake(25.f, 76.f);
        self.strokeEnd = 1.f;
        self.progress = 0.f;
        self.maxOffset = 25.f;
        self.textRext = CGRectMake(5, _origin.y-30, 40, 20);
    }
    return self;
    
}
-(void)dealloc{
    CGColorRelease(_strokeColor);
}
-(instancetype)initWithLayer:(id)layer{
    if (self = [super initWithLayer:layer]) {
        self.strokeEnd = 1.f;
        self.origin = CGPointMake(25.f, 76.f);
    }
    return self;
}
-(void)setProgress:(float)progress{
    _progress = MIN(1.f, MAX(0.f, progress));
    [self setNeedsDisplay];
}
-(void)setStrokeColor:(CGColorRef)strokeColor{
    CGColorRelease(_strokeColor);
    _strokeColor = strokeColor;
    CGColorRetain(_strokeColor);//必须进行这一步持有，否则对象释放
    [self setNeedsDisplay];
}

-(void)drawInContext:(CGContextRef)ctx{
    _origin.x = 25.f;
    CGFloat offsetX = _origin.x + MAX_LENGTH*_progress;
    CGFloat offsetY = _origin.y + _maxOffset*(1-fabs(_progress-.5f)*2);
    CGFloat contactX = 25.f + MAX_LENGTH*_strokeEnd;
    CGFloat contactY = _origin.y + _maxOffset*(1-fabs(_strokeEnd-.5f)*2);
    CGRect textRect = CGRectOffset(_textRext, MAX_LENGTH * _progress, _maxOffset * (1 - fabs(_progress - .5f)*2));
    if (_report) {
        _report((NSUInteger)(_progress * 100),textRect,_strokeColor);
    }
    CGMutablePathRef linePath = CGPathCreateMutable();
    //绘制背景线条
    if (_strokeEnd > _progress) {
        CGFloat scale = _progress == 0 ?:(1-(_strokeEnd - _progress) / (1 - _progress));
        contactY = _origin.y + (offsetY - _origin.y) *scale;
        CGPathMoveToPoint(linePath, NULL, contactX, contactY);
    }else{
        CGFloat scale = _progress == 0 ?: _strokeEnd / _progress;
        contactY = (offsetY - _origin.y) *scale + _origin.y;
        CGPathMoveToPoint(linePath, NULL, contactX, contactY);
        CGPathAddLineToPoint(linePath, NULL, offsetX, offsetY);
    }
    CGPathAddLineToPoint(linePath, NULL, _origin.x = MAX_LENGTH, _origin.y);
    [self setPath:linePath onContext:ctx color:RGB(204, 204, 204).CGColor];
    CGPathRelease(linePath);
    linePath = CGPathCreateMutable();
    
    //绘制进度线条
    if (_progress != 0.f) {
        NSLog(@"%f,progress",_progress);
        CGPathMoveToPoint(linePath, NULL, _origin.x, _origin.y);
        if (_strokeEnd > _progress) {
            CGPathAddLineToPoint(linePath, NULL, offsetX, offsetY);
        }
        CGPathAddLineToPoint(linePath, NULL, contactX, contactY);
    }else{
        if (_strokeEnd != 1.f && _strokeEnd != 0.f) {
            NSLog(@"%f, end", _progress);
            CGPathMoveToPoint(linePath, NULL, _origin.x, _origin.y);
            CGPathAddLineToPoint(linePath, NULL, contactX, contactY);
        }
    }
    [self setPath: linePath onContext: ctx color: [UIColor colorWithRed: 66/255.f green: 1.f blue: 66/255.f alpha: 1.f].CGColor];
    CGPathRelease(linePath);
}
-(void)setPath:(CGPathRef) path onContext: (CGContextRef)ctx color:(CGColorRef)color{
    CGContextAddPath(ctx, path);
    CGContextSetLineWidth(ctx, 5.f);
    CGContextSetStrokeColorWithColor(ctx, color);
    //设置线条起点和终点的样式为圆角
    CGContextSetLineCap(ctx, kCGLineCapRound);
    //设置线条的转角的样式为圆角
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    //渲染（绘制出一条空心的线）
    CGContextStrokePath(ctx);
}
@end
