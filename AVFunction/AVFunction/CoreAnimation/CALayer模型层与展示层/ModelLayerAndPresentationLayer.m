//
//  ModelLayerAndPresentationLayer.m
//  AVFunction
//
//  Created by shoule on 2018/9/19.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "ModelLayerAndPresentationLayer.h"

@interface ModelLayerAndPresentationLayer ()
@property(nonatomic,strong)UIView *myView;
@property(nonatomic,assign)NSTimeInterval beginTime;
@property(nonatomic,strong)CADisplayLink *animationLink;
@end

@implementation ModelLayerAndPresentationLayer

-(UIView *)myView{
    if (!_myView) {
        _myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        _myView.backgroundColor = [UIColor yellowColor];
        
    }
    return _myView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myView];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self modelAndShowSame];
    [self avarAnimationWithView];
    
}
//
-(CGFloat)_interpolateFrom:(CGFloat)from to:(CGFloat)to percent:(CGFloat)percent{
    //匀速运动
    return from +(to - from) *percent;
}

-(void)avarAnimationWithView{
    CADisplayLink *animationLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(avarAnimation)];
    [animationLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.beginTime = CACurrentMediaTime();
    self.animationLink = animationLink;
}
-(void)avarAnimation{
    NSTimeInterval currentTime = CACurrentMediaTime() - self.beginTime;
    CGPoint fromPoint = CGPointMake(10, 20);
    CGPoint toPoint = CGPointMake(300, 400);
    NSTimeInterval duration = 2.78;
    
    CGFloat percent = currentTime/duration;
    if (percent > 1) {
        percent = 1;
        [self.animationLink invalidate];
    }
    CGFloat x = [self _interpolateFrom:fromPoint.x to:toPoint.x percent:percent];
    CGFloat y = [self _interpolateFrom:fromPoint.y to:toPoint.y percent:percent];
    self.myView.center = CGPointMake(x, y);
}
/**总结

在CALayer内部，它控制着两个属性：presentationLayer(以下称为P)和modelLayer（以下称为M）。P只负责显示，M只负责数据的存储和获取。我们对layer的各种属性赋值比如frame，实际上是直接对M的属性赋值，而P将在每一次屏幕刷新的时候回到M的状态。比如此时M的状态是1，P的状态也是1，然后我们把M的状态改为2，那么此时P还没有过去，也就是我们看到的状态P还是1，在下一次屏幕刷新的时候P才变为2。而我们几乎感知不到两次屏幕刷新之间的间隙，所以感觉就是我们一对M赋值，P就过去了。

P就像是瞎子，M就像是瘸子，瞎子背着瘸子，瞎子每走一步（也就是每次屏幕刷新的时候）都要去问瘸子应该怎样走（这里的走路就是绘制内容到屏幕上），瘸子没法走，只能指挥瞎子背着自己走。可以简单的理解为：一般情况下，任意时刻P都会回到M的状态。

而当一个CAAnimation（以下称为A）加到了layer上面后，A就把M从P身上挤下去了。现在P背着的是A，P同样在每次屏幕刷新的时候去问他背着的那个家伙，A就指挥它从fromValue到toValue来改变值。而动画结束后，A会自动被移除，这时P没有了指挥，就只能大喊“M你在哪”，M说我还在原地没动呢，于是P就顺声回到M的位置了。这就是为什么动画结束后我们看到这个视图又回到了原来的位置，是因为我们看到在移动的是P，而指挥它移动的是A，M永远停在原来的位置没有动，动画结束后A被移除，P就回到了M的怀里。

动画结束后，P会回到M的状态（当然这是有前提的，因为动画已经被移除了，我们可以设置fillMode来继续影响P），但是这通常都不是我们动画想要的效果。我们通常想要的是，动画结束后，视图就停在结束的地方，并且此时我去访问该视图的属性（也就是M的属性），也应该就是当前看到的那个样子。按照官方文档的描述，我们的CAAnimation动画都可以通过设置modelLayer到动画结束的状态来实现P和M的同步。
//模型和显示同步*/
-(void)modelAndShowSame{
    UIView *view= [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    view.center= CGPointMake(200, 300);
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position";
    animation.duration= 2;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(80, 80)];
    animation.fillMode = kCAFillModeBoth;//向前向后填充初始状态到fromvalue ， tovalue到移除状态
    [view.layer addAnimation:animation forKey:nil];
    
    
    
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
