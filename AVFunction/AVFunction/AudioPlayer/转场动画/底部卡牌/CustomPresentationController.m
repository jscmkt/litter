//
//  CustomPresentationController.m
//  AVFunction
//
//  Created by shoule on 2018/9/10.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "CustomPresentationController.h"

#define CORNER_RADIUS 16.f
@interface CustomPresentationController()<UIViewControllerAnimatedTransitioning>

@property(nonatomic,strong)UIView *dimmingView;
@property(nonatomic,strong )UIView *presentationWrappingView;
@end
@implementation CustomPresentationController
/**
 初始化
 
 @param  presentedViewController  presentedViewController  跳转到这个控制器
 @param  presentingViewController presentingViewController 由这个控制器开始跳转
 @return return value description
 */
-(instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
        //自定义modalPresentationStyle
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
        
        
    }
    return self;
}
-(UIView*)presentedView{
    return self.presentationWrappingView;
}
//present将要执行时
-(void)presentationTransitionWillBegin{
    
    //社会组presrentationWrappingView和dimming的UI效果
    UIView *presentedViewControllerView = [super presentedView];
    presentedViewControllerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    {
        UIView *presentationWarpView = [[UIView alloc]initWithFrame:self.frameOfPresentedViewInContainerView];
        presentationWarpView.layer.shadowOpacity = 0.44f;
        presentationWarpView.layer.shadowRadius = 13.0f;
        //设置阴影的偏移量，如果为正数，则表示往右边偏移
        presentationWarpView.layer.shadowOffset = CGSizeMake(0, -6.f);
        self.presentationWrappingView = presentationWarpView;
        //圆角View
        UIView *presentationRoundedCornerView = [[UIView alloc]initWithFrame:UIEdgeInsetsInsetRect(presentationWarpView.bounds, UIEdgeInsetsMake(0, 0, CORNER_RADIUS, 0))];
        
        //autoresizingMask 这个属性 自动调整与父视图之间的边界距离
        presentationRoundedCornerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        presentationRoundedCornerView.layer.cornerRadius = CORNER_RADIUS;
        presentationRoundedCornerView.layer.masksToBounds = YES;
        [presentationRoundedCornerView addSubview:presentedViewControllerView];
        
        presentedViewControllerView.frame = UIEdgeInsetsInsetRect(presentationRoundedCornerView.bounds, UIEdgeInsetsMake(0, 0, CORNER_RADIUS, 0));
        
        [presentationWarpView addSubview:presentationRoundedCornerView];
    }
    {
        //背景图
        UIView *dimmingView = [[UIView alloc]initWithFrame:self.containerView.bounds];
        dimmingView.backgroundColor = [UIColor blackColor];
        dimmingView.opaque = NO;
        dimmingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [dimmingView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dimmingViewTapped:)]];
        self.dimmingView = dimmingView;
        [self.containerView addSubview:dimmingView];
        
        id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
        
        self.dimmingView.alpha = 0.f;
        [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self.dimmingView.alpha = 0.5f;
            
        } completion:NULL];
    }
}

#pragma mark Tap Gesture Recognizer

- (void)dimmingViewTapped:(UITapGestureRecognizer*)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}
//present执行结束后
-(void)presentationTransitionDidEnd:(BOOL)completed{
    if (completed == NO){
        self.presentationWrappingView = nil;
        self.dimmingView = nil;
    }
}
/** dismiss 将要执行时 */
-(void)dismissalTransitionWillBegin{
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.f;
    } completion:nil];
    
}

/* dismiss执行结束后 */
- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    if (completed == YES)
    {
        self.presentationWrappingView = nil;
        self.dimmingView = nil;
    }
}
#pragma mark layout
-(void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container{
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    if (container == self.presentedViewController) {
        [self.containerView setNeedsLayout];
    }
}

- (CGRect)frameOfPresentedViewInContainerView
{
    CGRect containerViewBounds = self.containerView.bounds;
    CGSize presentedViewContentSize = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerViewBounds.size];
    
    CGRect presentedViewControllerFrame = containerViewBounds;
    presentedViewControllerFrame.size.height = presentedViewContentSize.height;
    presentedViewControllerFrame.origin.y = CGRectGetMaxY(containerViewBounds) - presentedViewContentSize.height;
    return presentedViewControllerFrame;
}


- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize
{
    if (container == self.presentedViewController)
        
        return ((UIViewController*)container).preferredContentSize;
    else
        return [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
}

- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    
    self.dimmingView.frame = self.containerView.bounds;
    self.presentationWrappingView.frame = self.frameOfPresentedViewInContainerView;
}
#pragma mark UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return [transitionContext isAnimated] ? 0.35 : 0;
}

#pragma mark UIViewControllerTransitioningDelegate
- (UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    
    // 断言
    NSAssert(self.presentedViewController == presented, @"You didn't initialize %@ with the correct presentedViewController.  Expected %@, got %@.",
             self, presented, self.presentedViewController);
    
    return self;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    // 这一部分就不在注释啦
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = transitionContext.containerView;
    UIView *toView   = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    // 这个和前面的区分是一样的，为了区分是present还是dismiss,具体的看前面的代码注释
    BOOL isPresenting = (fromViewController == self.presentingViewController);
    
    CGRect __unused fromViewInitialFrame = [transitionContext initialFrameForViewController:fromViewController];
    
    CGRect fromViewFinalFrame = [transitionContext finalFrameForViewController:fromViewController];
    CGRect toViewInitialFrame = [transitionContext initialFrameForViewController:toViewController];
    CGRect toViewFinalFrame   = [transitionContext finalFrameForViewController:toViewController];
    
    [containerView addSubview:toView];
    
    // 是present
    if (isPresenting) {
        
        toViewInitialFrame.origin = CGPointMake(CGRectGetMinX(containerView.bounds), CGRectGetMaxY(containerView.bounds));
        toViewInitialFrame.size = toViewFinalFrame.size;
        toView.frame = toViewInitialFrame;
        
    } else {
        
        fromViewFinalFrame = CGRectOffset(fromView.frame, 0, CGRectGetHeight(fromView.frame));
    }
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:transitionDuration animations:^{
        
        if (isPresenting)
            
            toView.frame = toViewFinalFrame;
        else
            fromView.frame = fromViewFinalFrame;
        
    }completion:^(BOOL finished) {
        
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    return self;
}
@end
