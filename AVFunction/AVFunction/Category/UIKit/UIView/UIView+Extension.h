//
//  UIView+Extension.h
//  HJWCategory
//
//  Created by SaiDicaprio. on 15/6/3.
//  Copyright (c) 2015年 SaiDicaprio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;


//@property (assign, nonatomic) CGFloat mj_x;
//@property (assign, nonatomic) CGFloat mj_y;
//@property (assign, nonatomic) CGFloat mj_w;
//@property (assign, nonatomic) CGFloat mj_h;
//@property (assign, nonatomic) CGSize mj_size;
//@property (assign, nonatomic) CGPoint mj_origin;
- (UIViewController *)viewController;
@end
