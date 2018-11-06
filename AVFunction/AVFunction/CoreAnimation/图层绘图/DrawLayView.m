//
//  DrawLayView.m
//  AVFunction
//
//  Created by shoule on 2018/9/14.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "DrawLayView.h"
#import "DrawLayer.h"
@implementation DrawLayView

- (instancetype)initWithFrame:(CGRect)frame {
if (self=[super initWithFrame:frame]) {
    DrawLayer* layer = [[DrawLayer alloc]init];
    layer.bounds = CGRectMake(0, 0, 185, 185);
    layer.position = CGPointMake(160, 284);
    layer.backgroundColor = [UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
    
    //显示图层
    [layer setNeedsDisplay];
    [self.layer addSublayer:layer];
}
return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
