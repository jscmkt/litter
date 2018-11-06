//
//  UILabel+LHLabelCategory.h
//  
//
//  Created by Mac on 16/5/5.
//  Copyright © 2016年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LHLabelCategory)

- (void)setFont:(UIFont *)aFont andTextColor:(UIColor *)aColor;

- (void)setText:(NSString *)aText andFont:(UIFont *)aFont andTextColor:(UIColor *)aColor;

@end
