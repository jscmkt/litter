//
//  SwipeTransitionDelegate.h
//  AVFunction
//
//  Created by shoule on 2018/9/7.
//  Copyright © 2018年 WT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SwipeTransitionDelegate : NSObject<UIViewControllerTransitioningDelegate>

@property(nonatomic,strong)UIScreenEdgePanGestureRecognizer *gestureRecognizer;
@property(nonatomic,readwrite)UIRectEdge targetEdge;

@end
