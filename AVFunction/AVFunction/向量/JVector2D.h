//
//  JVector2D.h
//  AVFunction
//
//  Created by shoule on 2018/9/25.
//  Copyright © 2018年 WT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JVectorCoordinateSystem){
    JVectorCoordinateSystemUIKit,
    JVectorCoordinateSystemOpenGL,
};
//平面向量
@interface JVector2D : NSObject
@property(nonatomic)CGPoint startPoint;
@property(nonatomic)CGPoint endPoint;

@property(nonatomic,readonly)JVectorCoordinateSystem coordinateSystem;
/**
 *  设置坐标系，UIKit坐标系以左上角为坐标原点，OPGL坐标系以左下角为坐标原点，此设置将影响所有向量
 *
 *  @param coordinateSystem 坐标系枚举值
 */
+ (void)setVectorCoordinateSystem:(JVectorCoordinateSystem)coordinateSystem;

/**
 *  用两个点初始化一个向量
 *
 *  @param start 起始点
 *  @param end   结束点
 *
 *  @return 生成的向量
 */
- (instancetype)initWithStartPoint:(CGPoint)start endPoint:(CGPoint)end;

/**
 *  指定一个角度生成一个单位向量
 *
 *  @param radian 该向量在逆时针方向上到X轴正方向的角度
 *
 *  @return 单位向量
 */
- (instancetype)initAsIdentityVectorWithAngleToXPositiveAxis:(CGFloat)radian;

/**
 *  用一个CGPoint作为坐标表达式初始化一个向量，该向量起点在(0,0)点
 *
 *  @param position 向量坐标表达式
 *
 *  @return 生成的向量
 */
- (instancetype)initWithCoordinateExpression:(CGPoint)position;

/**
 *  相当于复制一个向量
 *
 *  @param vector 要复制的向量
 *
 *  @return 生成的向量
 */
+ (instancetype)vectorWithVector:(JVector2D *)vector;

@end

@interface JVector2D (VectorDescriptions)

/**
 *  向量长度
 *
 *  @return 向量长度
 */
- (CGFloat)length;

/**
 *  起点和方向不变，改变终点位置以让向量长度等于传入的长度。
 *
 *  @param length 要改变的长度
 */
- (void)setLength:(CGFloat)length;

/**
 *  向量间的夹角，是弧度值， <=PI
 *
 *  @param oVector 与这个向量的夹角
 *
 *  @return 夹角弧度值
 */
- (CGFloat)angleOfOtherVector:(JVector2D *)oVector;

/**
 *  与x轴正方向的夹角
 *
 *  @return 夹角弧度值
 */
- (CGFloat)angleOfXAxisPositiveVector;

/**
 *  向量的坐标形式，也就是将起始点移到原点后终止点所在的位置
 *
 *  @return 向量坐标表达式
 */
- (CGPoint)coordinateExpression;

/**
 *  判断两个向量是否相等
 *
 *  @param aVector 要比较的向量
 *
 *  @return 是否相等
 */
- (BOOL)isEqualToVector:(JVector2D *)aVector;

/**
 *  该向量到某个向量的顺时针到角
 *
 *  @param vector 要到的向量
 *
 *  @return 到角弧度值
 */
- (CGFloat)clockwiseAngleToVector:(JVector2D *)vector;

/**
 *  该向量到某个向量的逆时针到角
 *
 *  @param vector 要到的向量
 *
 *  @return 到角弧度值
 */
- (CGFloat)antiClockwiseAngleToVector:(JVector2D *)vector;

@end

@interface JVector2D(SpecialVectors)

/**
 *  x轴正方向的单位向量
 *
 *  @return x轴正方向的单位向量
 */
+ (JVector2D *)xPositiveIdentityVector;

/**
 *  x轴负方向的单位向量
 *
 *  @return x轴负方向的单位向量
 */
+ (JVector2D *)xNegativeIdentityVector;

/**
 *  y轴正方向的单位向量
 *
 *  @return y轴正方向的单位向量
 */
+ (JVector2D *)yPositiveIdentityVector;

/**
 *  y轴负方向的单位向量
 *
 *  @return y轴负方向的单位向量
 */
+ (JVector2D *)yNegativeIdentityVector;

/**
 *  零向量
 *
 *  @return 零向量
 */
+ (JVector2D *)zeroVector;

@end


@interface JVector2D (VectorArithmetic)

/**
 *  向量加法，自身被另一个向量加，方法将改变自身的结束点
 *
 *  @param vector 要加的向量
 */
- (void)plusByOtherVector:(JVector2D *)vector;
/**
 *  向量加法，将两个向量相加然后返回，不影响自身的结束点
 *
 *  @param aVector 要加的向量
 *  @param oVector 另一个要加的向量
 *
 *  @return 加起来后的结果
 */
+ (JVector2D *)aVector:(JVector2D *)aVector plusByOtherVector:(JVector2D *)oVector;

/**
 *  本向量被另一个向量减：self - vector，将影响自身的结束点
 *
 *  @param vector 自身要减的向量
 */
- (void)substractedByOtherVector:(JVector2D *)vector;
/**
 *  用一个向量去减另一个向量，不影响自身的结束点
 *
 *  @param aVector 被减向量
 *  @param oVector 用这个向量来减被减向量
 *
 *  @return 减后的向量
 */
+ (JVector2D *)aVector:(JVector2D *)aVector substractedByOtherVector:(JVector2D *)oVector;

/**
 *  数乘，将会影响自身的结束点
 *
 *  @param number 要乘的数
 */
- (void)multipliedByNumber:(CGFloat)number;
/**
 *  用一个向量乘以一个数，返回乘后的向量，不影响自身的结束点
 *
 *  @param aVector 被乘的向量
 *  @param number  乘数
 *
 *  @return 乘后的向量
 */
+ (JVector2D *)aVector:(JVector2D *)aVector multipliedByNumber:(CGFloat)number;

/**
 *  向量数量积、点积，自身点乘另一个向量，不影响自身的结束点
 *
 *  @param vector 要点乘的向量
 *
 *  @return 点乘结果，是标量值
 */
- (CGFloat)dotProductedByOtherVector:(JVector2D *)vector;
/**
 *  用一个向量点乘另一个向量，不影响自身的结束点
 *
 *  @param aVector 一个向量
 *  @param oVector 点乘另一个向量
 *
 *  @return 点乘结果，是标量值
 */
+ (CGFloat)aVector:(JVector2D *)aVector dotProductedByOtherVector:(JVector2D *)oVector;

// 向量积（叉积，外积）
// 叉积结果的方向会产生第三维度，在本类中暂不考虑第三维度
//- (void)crossProductedByOtherVector:(DHVector *)vector;
//+ (DHVector *)aVector:(DHVector *)aVector crossProductedByOtherVector:(DHVector *)oVector;

@end

@interface JVector2D (VectorOperations)

/**
 *  将起始点平移至某个点，和原向量相等
 *
 *  @param point 要平移到的点
 */
- (void)translationToPoint:(CGPoint)point;

/**
 *  顺时针旋转一个弧度
 *
 *  @param radian 要旋转的弧度值
 */
- (void)rotateClockwiselyWithRadian:(CGFloat)radian;

/**
 *  逆时针旋转一个弧度
 *
 *  @param radian 要旋转的弧度值
 */
- (void)rotateAntiClockwiselyWithRadian:(CGFloat)radian;

/**
 *  将向量反向
 */
- (void)reverse;

@end

@interface JVector2D (CoordinateSystemConverting)
/**
 *  将UIKit坐标系下的点转换为OPGL坐标系下的点
 *
 *  @param point  UIKit坐标系下的点
 *  @param height 参考系高度
 *
 *  @return OPGL坐标系下的点
 */
+ (CGPoint)openGLPointFromUIKitPoint:(CGPoint)point referenceHeight:(CGFloat)height;

/**
 *  将OPGL坐标系下的点转换为UIKit坐标系下的点
 *
 *  @param point  OPGL坐标系下的点
 *  @param height 参考系高度
 *
 *  @return UIKit坐标系下的点
 */
+ (CGPoint)uikitPointFromOpenGLPoint:(CGPoint)point referenceHeight:(CGFloat)height;

@end

@interface JVector2D(DrawVector)

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor * lineColor;

- (void)drawOnView:(UIView *)view;

@end
