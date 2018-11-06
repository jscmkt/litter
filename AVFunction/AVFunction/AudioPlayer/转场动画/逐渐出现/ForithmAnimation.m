//
//  ForithmAnimation.m
//  AVFunction
//
//  Created by shoule on 2018/9/4.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "ForithmAnimation.h"

@implementation ForithmAnimation

//转场动画执行的时间
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.35;
    
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    /*
     
     typedef NS_ENUM(NSInteger, UIModalTransitionStyle) {
     
     // 默认的从下到上
     UIModalTransitionStyleCoverVertical = 0,
     // 翻转
     UIModalTransitionStyleFlipHorizontal __TVOS_PROHIBITED,
     // 渐显
     UIModalTransitionStyleCrossDissolve,
     // 类似你翻书时候的效果
     UIModalTransitionStylePartialCurl NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
     };
     
     */
    //
    UIView *contentView = transitionContext.containerView;
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    fromView.frame = [transitionContext initialFrameForViewController:fromViewController];
    toView.frame = [transitionContext finalFrameForViewController:toViewController];
    fromView.alpha = 1.0f;
    toView.alpha = 0.0f;
    
    //在present和dismiss时，必须将toView 添加到视图层次中
    [contentView addSubview:toView];
    //获取执行时长
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:transitionDuration animations:^{
        fromView.alpha = 0.0f;
        toView.alpha = 1.0f;
        
    }completion:^(BOOL finished) {
        //transitionWasCancelled 这个方法判断转场是否已经取消了，下面的completeTransition设置转仓完成
        //动画结束后一定要调用completeTransition方法
        //通过transitionWasCancelled()方法来获取转仓的状态，使用completeTransition:来完成或取消转场。
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end
