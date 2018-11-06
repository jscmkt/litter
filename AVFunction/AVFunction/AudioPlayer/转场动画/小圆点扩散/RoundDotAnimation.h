//
//  RoundDotAnimation.h
//  AVFunction
//
//  Created by shoule on 2018/9/11.
//  Copyright © 2018年 WT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoundDotAnimation : NSObject<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>

@property(nonatomic,assign) BOOL  isPresentOrDismiss;
@end
