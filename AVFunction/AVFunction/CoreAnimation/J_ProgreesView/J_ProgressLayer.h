//
//  J_ProgressLayer.h
//  AVFunction
//
//  Created by shoule on 2018/9/12.
//  Copyright © 2018年 WT. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
typedef void(^J_ProgressReport)(NSInteger progress,CGRect textRect,CGColorRef textColor);
@interface J_ProgressLayer : CALayer
@property(nonatomic,assign) float strokeEnd;
@property(nonatomic,assign) float progress;
@property(nonatomic,assign)CGColorRef strokeColor;
@property(nonatomic,assign)CGColorRef fillColor;
@property(nonatomic,copy) J_ProgressReport report;
@end
