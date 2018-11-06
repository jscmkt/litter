//
//  J_ActivituIndicator.m
//  AVFunction
//
//  Created by shoule on 2018/9/13.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "J_ActivituIndicator.h"
@interface J_ActivituIndicator()
@property(nonatomic,strong)UIImageView *animationCircle;
@end
@implementation J_ActivituIndicator
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self =[super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}
-(void)commonInit{
    UIImageView *logo = [[UIImageView alloc]initWithImage:@"loading_logo".image];
//    logo.frame = self.frame;
    [self addSubview: logo];
    self.animationCircle = [[UIImageView alloc]initWithImage:@"loading_indicator".image];
//    self.animationCircle.frame = self.frame;
    [self addSubview:self.animationCircle];
}
-(void)startAnimation{
    CAAnimation *existAnimation = [self.animationCircle.layer animationForKey:@"rotate"];
    if (existAnimation) {
        return;
    }
    self.hidden = NO;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @0;
    animation.toValue = @(2*M_PI);
    animation.duration = 1.5f;
    animation.repeatCount = HUGE_VALF;
    [self.animationCircle.layer addAnimation:animation forKey:@"rotate"];
}
-(void)stopAnimation{
    if (self.hidesWhenStopped) {
        self.hidden = YES;
        
    }
    [self.animationCircle.layer removeAllAnimations];
}
-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    self.bounds = CGRectMake(0, 0, 30, 30);
}
@end
