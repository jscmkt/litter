//
//  SpringTransitionAnimation.m
//  AVFunction
//
//  Created by shoule on 2018/9/10.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "SpringTransitionAnimation.h"

@implementation SpringTransitionAnimation
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.35;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    // 下面这几个参数的获取和意义我们不说了，前面代码中都有
    UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //UIView           * fromView           = [transitionContext viewForKey:UITransitionContextFromViewKey];
    //UIView           * toView             = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView           * contextView        = [transitionContext containerView];
    
    BOOL isPresent   = (toViewController.presentingViewController == fromViewController);
    UIView *tempView = nil;
    if (isPresent) {
        //截屏
        tempView = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
//        tempView = [[UIView alloc]init];
//        tempView.backgroundColor = randomColor;
        tempView.frame = fromViewController.view.frame;
        fromViewController.view.hidden = YES;
        [contextView addSubview:tempView];
        [contextView addSubview:toViewController.view];
        toViewController.view.frame = CGRectMake(0, contextView.height, contextView.width, 400);
        
    }else{
        
        //参照present动画的逻辑，present成功后，containerView的最后一个子视图就是截图视图，我们将其取出准备动画
        NSArray *subViewsArray = contextView.subviews;
        tempView = subViewsArray[MIN(subViewsArray.count, MAX(0, subViewsArray.count-2))];
    }
    if (isPresent) {
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toViewController.view.transform = CGAffineTransformMakeTranslation(0, -400);
            tempView.transform = CGAffineTransformMakeTranslation(0.85, 0.85);
        } completion:^(BOOL finished) {
            BOOL cancle = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!cancle];
            if (cancle) {
                
                //失败后，我们要把vc1显示出来
                fromViewController.view.hidden = NO;
                //然后移除截图视图，因为下次触发present会重新截图
                [tempView removeFromSuperview];
            }
        }];
    }else{
        
        // Dismiss
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            fromViewController.view.transform = CGAffineTransformIdentity;
            tempView.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            if ([transitionContext transitionWasCancelled]) {
                
                //失败了接标记失败
                [transitionContext completeTransition:NO];
            }else{
                //如果成功了，我们需要标记成功，同时让vc1显示出来，然后移除截图视图，
                [transitionContext completeTransition:YES];
                toViewController.view.hidden = NO;
                [tempView removeFromSuperview];
            }
        }];
    }
}
@end
