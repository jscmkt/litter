//
//  JVector2D.m
//  AVFunction
//
//  Created by shoule on 2018/9/25.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "JVector2D.h"
//单位向量长度
#define IDENTITY_LENDTH 1
static NSString * const kJVectorCoordinateSystemKey = @"kJVectorCoordinateSystemKey";
@implementation JVector2D

+(void)initialize{
    [self setVectorCoordinateSystem:JVectorCoordinateSystemUIKit];
}

+(void)setVectorCoordinateSystem:(JVectorCoordinateSystem)coordinateSystem{
    [[NSUserDefaults standardUserDefaults]setObject:@(coordinateSystem) forKey:kJVectorCoordinateSystemKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(JVectorCoordinateSystem)coordinateSystem{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kJVectorCoordinateSystemKey] integerValue];
}

-(instancetype)initAsIdentityVectorWithAngleToXPositiveAxis:(CGFloat)radian{
    self = [JVector2D xPositiveIdentityVector];
    [self rotateClockwiselyWithRadian:radian];
    return self;
}

-(instancetype)initWithStartPoint:(CGPoint)start endPoint:(CGPoint)end{
    self = [super init];
    _startPoint = start;
    _endPoint = end;
    return self;
}
-(instancetype)initWithCoordinateExpression:(CGPoint)position{
    self = [self initWithStartPoint:CGPointZero endPoint:position];
    return self;
}
+(instancetype)vectorWithVector:(JVector2D *)vector{
    JVector2D *aVector = [[JVector2D alloc] initWithStartPoint:vector.startPoint endPoint:vector.endPoint];
    
    return aVector;
}
-(NSString *)description{
    return [NSString stringWithFormat:@"start : %@ , end : %@ , coordinate : %@",NSStringFromCGPoint(self.startPoint),NSStringFromCGPoint(self.endPoint),NSStringFromCGPoint([self coordinateExpression])];
}
@end
@implementation JVector2D(VectorDescriptions)
-(CGFloat)length{
    return sqrt(pow((_startPoint.y-_endPoint.y), 2)+pow((_startPoint.x-_endPoint.x), 2));
}
-(void)setLength:(CGFloat)length{
    [self multipliedByNumber:length/self.length];
}
-(CGFloat)angleOfOtherVector:(JVector2D *)oVector{
    //通过向量点积的集合意义反解向量夹角
    CGFloat cos = [self dotProductedByOtherVector:oVector] / ([self length] * [oVector length]);
    if (cos > 1) {
        cos = 1;
    }
    if (cos < -1) {
        cos = -1;
    }
    return acos(cos);
}
-(CGFloat)angleOfXAxisPositiveVector{
    return [self angleOfOtherVector:[JVector2D xPositiveIdentityVector]];
}

-(CGPoint)coordinateExpression{
    CGPoint p = CGPointZero;
    p.x = _endPoint.x - _startPoint.x;
    p.y = _endPoint.y - _startPoint.y;
    return p;
}

- (BOOL)isEqualToVector:(JVector2D *)aVector
{
    CGPoint selfExpression = [self coordinateExpression];
    CGPoint expression = [aVector coordinateExpression];
    return CGPointEqualToPoint(selfExpression, expression);
}

#pragma mark - 倒角
//顺时针倒角 = 另一个向量到该向量的逆时针倒角

- (CGFloat)clockwiseAngleToVector:(JVector2D *)vector
{
    return [vector antiClockwiseAngleToVector:self];
}


//如果另一个向量在这个向量的逆时针方向上(夹角小于PI)，这倒角 = 夹角
//若不是，则倒角 = 2PI - 夹角
-(CGFloat)antiClockwiseAngleToVector:(JVector2D *)vector{
    //判断是否在逆时针上
    //首选如果他们的夹角是PI，则直接返回
    if ([self angleOfOtherVector:vector] == M_PI) {
        return  M_PI;
    }
    //如果他们两个向量相逢，则返回0
    if ([self isEqualToVector:vector]) {
        return 0;
    }
    
    //然后，将该向量延逆时针方向旋转一度，如果他们的夹角减小，则是在逆时针方向
    CGFloat angle = [self angleOfOtherVector:vector];
    
    JVector2D *tempVector = [JVector2D vectorWithVector:self];
    [tempVector rotateAntiClockwiselyWithRadian:0.01/180.f*M_PI];
    if ([tempVector angleOfOtherVector:vector] < angle) {
        return angle;
    }
    return (2 * M_PI) - angle;
}
@end



#pragma mark - 向量运算
@implementation JVector2D(VectorArithmetic)
//类方法返回的向量起始点为坐标原点
//加法
-(void)plusByOtherVector:(JVector2D *)vector{
    CGPoint tp = _startPoint;
    [self translationToPoint:CGPointMake(0, 0)];
    CGPoint p = [vector coordinateExpression];
    _endPoint = CGPointMake(_endPoint.x+p.x, _endPoint.y+p.y);
    [self translationToPoint:tp];
}
+(JVector2D *)aVector:(JVector2D *)aVector plusByOtherVector:(JVector2D *)oVector
{
    CGPoint p1 = [aVector coordinateExpression];
    CGPoint p2 = [oVector coordinateExpression];
    
    JVector2D *vector = [[JVector2D alloc]initWithStartPoint:CGPointMake(0, 0) endPoint:CGPointMake(p1.x + p2.x, p1.y + p2.y)];
    return vector;
}

//减法
//本向量被另一个向量减：self - vector
-(void)substractedByOtherVector:(JVector2D *)vector{
    CGPoint tp = _startPoint;
    [self translationToPoint:CGPointMake(0, 0)];
    CGPoint p = [vector coordinateExpression];
    _endPoint = CGPointMake(_endPoint.x - p.x, _endPoint.y - p.y);
    [self translationToPoint:tp];
}

+ (JVector2D *)aVector:(JVector2D *)aVector substractedByOtherVector:(JVector2D *)oVector
{
    CGPoint p1 = [aVector coordinateExpression];
    CGPoint p2 = [oVector coordinateExpression];
    
    JVector2D * vector = [[JVector2D alloc] initWithStartPoint:CGPointMake(0, 0) endPoint:CGPointMake(p1.x-p2.x, p1.y-p2.y)];
    
    return vector;
}
//数乘
- (void)multipliedByNumber:(CGFloat)number
{
    CGPoint startPoint = self.startPoint;
    [self translationToPoint:CGPointZero];
    
    self.endPoint = CGPointMake(_endPoint.x * number, _endPoint.y * number);
    [self translationToPoint:startPoint];
}
+(JVector2D *)aVector:(JVector2D *)aVector multipliedByNumber:(CGFloat)number{
    
    CGPoint tp = aVector.startPoint;
    [aVector translationToPoint:CGPointMake(0, 0)];
    CGPoint p = CGPointMake(aVector.endPoint.x * number, aVector.endPoint.y * number);
    
    JVector2D * vector = [[JVector2D alloc] initWithCoordinateExpression:p];
    
    [aVector translationToPoint:tp];
    
    return vector;
}


// 数量积（点积）
- (CGFloat)dotProductedByOtherVector:(JVector2D *)vector
{
    return [JVector2D aVector:self dotProductedByOtherVector:vector];
}

+ (CGFloat)aVector:(JVector2D *)aVector dotProductedByOtherVector:(JVector2D *)oVector
{
    CGPoint p = [aVector coordinateExpression];
    CGPoint op = [oVector coordinateExpression];
    return p.x * op.x + p.y * op.y;
}

@end


@implementation JVector2D(VectorOperations)
#pragma mark - 平移
-(void)translationToPoint:(CGPoint)point{
    _endPoint = CGPointMake(point.x - _startPoint.x + _endPoint.x, point.y - _startPoint.y + _endPoint.y);
    _startPoint = point;
}

#pragma mark - 旋转
-(void)rotateWithCoordinateSystem:(JVectorCoordinateSystem)coordinateSystem radian:(CGFloat)randian clockWisely:(BOOL)flag{
    if (coordinateSystem == JVectorCoordinateSystemOpenGL) {
        [self rotateInOpenGLSystemWithRadian:randian clockwisely:flag];
    }else{
        [self rotateInOpenGLSystemWithRadian:randian clockwisely:!flag];
    }
}
-(void)rotateInOpenGLSystemWithRadian:(CGFloat)radin clockwisely:(BOOL)flag{
    //顺时针的
    if (flag) {
        //首先将向量平移至原点
        CGPoint point = _startPoint;
        [self translationToPoint:CGPointMake(0, 0)];
        //计算沿着原点旋转后的endPoint
        CGFloat x1 = _endPoint.x * cos(radin) + _endPoint.y * sin(radin);
        CGFloat y1 = -_endPoint.x * sin(radin) + _endPoint.y * cos(radin);
        
        _endPoint = CGPointMake(x1, y1);
        //将startPoint 移回原点
        [self translationToPoint:point];
    }else{//逆时针
        
        //首先将向量平移至原点
        CGPoint point = _startPoint;
        [self translationToPoint:CGPointMake(0, 0)];
        //计算沿着原点旋转后的endPoint
        CGFloat x1 = _endPoint.x * cos(radin) - _endPoint.y * sin(radin);
        CGFloat y1 = _endPoint.x * sin(radin) + _endPoint.y * cos(radin);
        
        _endPoint = CGPointMake(x1, y1);
        //将startPoint 移回原点
        [self translationToPoint:point];
    }
}

// 顺时针
- (void)rotateClockwiselyWithRadian:(CGFloat)radian
{
    [self rotateWithCoordinateSystem:self.coordinateSystem radian:radian clockWisely:YES];
}

// 逆时针
- (void)rotateAntiClockwiselyWithRadian:(CGFloat)radian
{
    [self rotateWithCoordinateSystem:self.coordinateSystem radian:radian clockWisely:NO];
}
-(void)reverse{
    CGPoint startPoint = self.startPoint;
    self.startPoint = self.endPoint;
    self.endPoint = startPoint;
}

@end


@implementation JVector2D(SpecialVectors)
#pragma mark - 特殊向量
+(JVector2D *)xPositiveIdentityVector{
    JVector2D *vector = [[JVector2D alloc]initWithCoordinateExpression:CGPointMake(IDENTITY_LENDTH, 0)];
    return vector;
}
+(JVector2D *)xNegativeIdentityVector{
    JVector2D *vector = [[JVector2D alloc]initWithCoordinateExpression:CGPointMake(-IDENTITY_LENDTH, 0)];
    return vector;
}
+(JVector2D *)yPositiveIdentityVector{
    JVector2D *vector = [[JVector2D alloc]initWithCoordinateExpression:CGPointMake(0, IDENTITY_LENDTH)];
    return vector;
}
+(JVector2D *)yNegativeIdentityVector{
    JVector2D *vector = [[JVector2D alloc]initWithCoordinateExpression:CGPointMake(0, -IDENTITY_LENDTH)];
    return vector;
}
+(JVector2D *)zeroVector{
    JVector2D *vector = [[JVector2D alloc]initWithCoordinateExpression:CGPointZero];
    return vector;
    
}
@end

#pragma mark - 坐标转换

@implementation JVector2D (CoordinateSystemConverting)

+ (CGPoint)openGLPointFromUIKitPoint:(CGPoint)point referenceHeight:(CGFloat)height
{
    CGPoint p = CGPointZero;
    p.x = point.x;
    p.y = height - point.y;
    
    return p;
}

+ (CGPoint)uikitPointFromOpenGLPoint:(CGPoint)point referenceHeight:(CGFloat)height
{
    CGPoint p = CGPointZero;
    p.x = point.x;
    p.y = height - point.y;
    
    return p;
}


@end
#import <objc/runtime.h>
@implementation JVector2D(DrawVector)
static const void * kJVectorLineWidthKey = &kJVectorLineWidthKey;
static const void * kJVectorLineColorKey = &kJVectorLineColorKey;

@dynamic lineWidth,lineColor;
-(CGFloat)lineWidth{
    return [objc_getAssociatedObject(self, kJVectorLineWidthKey) floatValue];
}
-(void)setLineWidth:(CGFloat)lineWidth{
    objc_setAssociatedObject(self, kJVectorLineWidthKey, @(lineWidth), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIColor *)lineColor
{
    return objc_getAssociatedObject(self, kJVectorLineColorKey);
}

- (void)setLineColor:(UIColor *)lineColor
{
    objc_setAssociatedObject(self, kJVectorLineColorKey, lineColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)drawOnView:(UIView *)view{
    
    CAShapeLayer * shapeLayer = [self shapeLayer];
    shapeLayer.frame = view.bounds;
    [view.layer addSublayer:shapeLayer];
}
-(CAShapeLayer *)shapeLayer{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:self.startPoint];
    [bezierPath addLineToPoint:self.endPoint];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = self.lineWidth;
    shapeLayer.strokeColor = self.lineColor.CGColor;
    shapeLayer.lineCap = kCALineCapButt;
    shapeLayer.path = bezierPath.CGPath;
    
    return shapeLayer;
}
@end

