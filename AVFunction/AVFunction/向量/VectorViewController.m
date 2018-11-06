//
//  VectorViewController.m
//  AVFunction
//
//  Created by shoule on 2018/9/27.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "VectorViewController.h"
#import "JVector2D.h"
@interface VectorViewController ()

@end

@implementation VectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawThing];
    [self drawRefularPolygonAtCenter:self.view.center edgeCount:8 edgeLenth:100];
}
//简单绘制
-(void)drawThing{
    
    [JVector2D setVectorCoordinateSystem:JVectorCoordinateSystemUIKit];
    JVector2D *vector = [[JVector2D alloc] initWithCoordinateExpression:CGPointMake(100, 100)];
    vector = [[JVector2D alloc] initAsIdentityVectorWithAngleToXPositiveAxis:M_PI/4];
    [vector multipliedByNumber:100*sqrt(2)];
    
    JVector2D *aVector = [[JVector2D alloc]initWithCoordinateExpression:CGPointMake(80, 0)];
    [aVector translationToPoint:CGPointMake(100, 100)];
    [aVector multipliedByNumber:2];
    
    [aVector rotateClockwiselyWithRadian:M_PI/8];
    
    JVector2D *resultVector = [JVector2D aVector:vector plusByOtherVector:aVector];
    resultVector.lineWidth = 2;
    resultVector.lineColor = [UIColor blackColor];
    [resultVector drawOnView:self.view];
    
    if ([[JVector2D aVector:resultVector substractedByOtherVector:vector] isEqualToVector:aVector]) {
        NSLog(@"加减法的实现没有问题");
    }
    
    vector.lineColor = [UIColor redColor];
    vector.lineWidth = 2;
    
    aVector.lineColor = [UIColor blueColor];
    aVector.lineWidth = 2;
    NSLog(@"%f",[vector angleOfOtherVector:aVector]/M_PI*180);
    
    [vector drawOnView:self.view];
    [aVector drawOnView:self.view];
}
#pragma  mark - 多边形绘制
-(void)drawRefularPolygonAtCenter:(CGPoint)center edgeCount:(int)edgeCount edgeLenth:(CGFloat)length{
    //响铃两个定点和中心点连接后形成的角度
    CGFloat innerAnglge = M_PI*2/edgeCount;
    //计算左下角那个定点的坐标 (cot是余切，hint：从中心点想变作垂线）
    CGFloat x1 = -length/2;
    CGFloat cot = cos(innerAnglge/2)/sin(innerAnglge/2);
    CGFloat y1 = length/2 * cot;
    //构造初始向量
    JVector2D *vector = [[JVector2D alloc] initWithCoordinateExpression:CGPointMake(x1, y1)];
    [vector translationToPoint:center];
    NSMutableArray *vertexes = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<edgeCount; ++i) {
        NSValue *vertex = [NSValue valueWithCGPoint:vector.endPoint];
        [vertexes addObject:vertex];
        //旋转向量
        [vector rotateClockwiselyWithRadian:innerAnglge];
    }
    //绘制
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [vertexes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint vertex = [obj CGPointValue];
        if (idx == 0) {
            [bezierPath moveToPoint:vertex];
            
        }else{
            [bezierPath addLineToPoint:vertex];
        }
        
        
        
    }];
    [bezierPath closePath];
    
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
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
