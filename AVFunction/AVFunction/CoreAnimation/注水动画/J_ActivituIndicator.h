//
//  J_ActivituIndicator.h
//  AVFunction
//
//  Created by shoule on 2018/9/13.
//  Copyright © 2018年 WT. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface J_ActivituIndicator : UIView
@property(nonatomic,assign)BOOL hidesWhenStopped;
-(void)startAnimation;
-(void)stopAnimation;
@end
