//
//  SwipeTransitionAnimation.h
//  AVFunction
//
//  Created by shoule on 2018/9/7.
//  Copyright © 2018年 WT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SwipeTransitionAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, readwrite) UIRectEdge targetEdge;

- (instancetype)initWithTargetEdge:(UIRectEdge)targetEdge;
@end
