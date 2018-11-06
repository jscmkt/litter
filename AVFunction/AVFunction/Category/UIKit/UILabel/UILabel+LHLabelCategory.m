//
//  UILabel+LHLabelCategory.m
//  
//
//  Created by Mac on 16/5/5.
//  Copyright © 2016年 imac. All rights reserved.
//

#import "UILabel+LHLabelCategory.h"

@implementation UILabel (LHLabelCategory)

- (void)setText:(NSString *)aText andFont:(UIFont *)aFont andTextColor:(UIColor *)aColor {
    self.text      = aText;
    self.font      = aFont;
    self.textColor = aColor;
}


- (void)setFont:(UIFont *)aFont andTextColor:(UIColor *)aColor {
    if (aFont) {
        self.font      = aFont;
    }
    if (aColor) {
        self.textColor = aColor;
    }
}





@end
