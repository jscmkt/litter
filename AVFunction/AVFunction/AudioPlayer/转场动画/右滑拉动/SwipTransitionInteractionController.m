//
//  SwipTransitionInteractionController.m
//  AVFunction
//
//  Created by shoule on 2018/9/7.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "SwipTransitionInteractionController.h"

@interface SwipTransitionInteractionController()

@property(nonatomic,weak) id<UIViewControllerContextTransitioning> transitionContext;
@property(nonatomic,strong,readonly) UIScreenEdgePanGestureRecognizer *gestureRecognizer;
@property(nonatomic,readonly)UIRectEdge edge;

@end
@implementation SwipTransitionInteractionController
-(instancetype)initWithGestureRecognizer:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer edgeForDragging:(UIRectEdge)edge{
    
    NSAssert(edge == UIRectEdgeTop || edge == UIRectEdgeBottom ||
             edge == UIRectEdgeLeft || edge == UIRectEdgeRight,
             @"edgeForDragging must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.");
    if (self = [super init]) {
        //初始化自己的手势和UIRectEdge edge
        //给手势添加 gestureRecognizerDidUpdate 方法
        _gestureRecognizer = gestureRecognizer;
        _edge = edge;
        [_gestureRecognizer addTarget:self action:@selector(gestureRecognizeDidUpdate:)];
    }
    return self;
}

// 使用init方法就抛出这个异常
- (instancetype)init{
    
    @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Use -initWithGestureRecognizer:edgeForDragging:" userInfo:nil];
}

/**
 前面代理通过 interactionControllerForPresentation 方法获取交互控制器的时候，手势返回的就是SwipTransitionInteractionController，这个时候就会调用这个方法
 
 interactive 交互
 */
-(void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    [super startInteractiveTransition:transitionContext];
    self.transitionContext = transitionContext;
}
// 手势触发该方法
-(void)gestureRecognizeDidUpdate:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
            
            // 调用updateInteractiveTransition来更新动画进度
            // 里面嵌套定义 percentForGesture 方法计算动画进度
            [self updateInteractiveTransition:[self percentForGessture:gestureRecognizer]];
            break;
            
        case UIGestureRecognizerStateEnded:
            if ([self percentForGessture:gestureRecognizer] >= .5f) {
                //完成交互
                [self finishInteractiveTransition];
                
            }else
                [self cancelInteractiveTransition];
            break;
        default:
            [self cancelInteractiveTransition];
            break;
    }
}
//计算动画的进度
-(CGFloat)percentForGessture:(UIScreenEdgePanGestureRecognizer*)gesture{
    UIView *transitionContainerView = self.transitionContext.containerView;
    //手势滑动 在transitionContainerView中的位置
    //这个位子可以具体根据你的需求确认
    CGPoint locationInSourceView = [gesture locationInView:transitionContainerView];
    
    CGFloat width = CGRectGetWidth(transitionContainerView.bounds);
    CGFloat height = CGRectGetHeight(transitionContainerView.bounds);
    
    if (self.edge == UIRectEdgeRight)
        
        return (width - locationInSourceView.x) / width;
    else if (self.edge == UIRectEdgeLeft)
        
        return locationInSourceView.x / width;
    else if (self.edge == UIRectEdgeBottom)
        
        return (height - locationInSourceView.y) / height;
    else if (self.edge == UIRectEdgeTop)
        
        return locationInSourceView.y / height;
    else
        return 0.f;
    
}


-(void)dealloc{
    [self.gestureRecognizer removeTarget:self action:@selector(gestureRecognizeDidUpdate:)];
}
@end
