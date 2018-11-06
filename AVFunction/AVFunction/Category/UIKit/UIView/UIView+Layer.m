//
//  UIView+Layer.m
//  NeiHan
//
//  Created by Charles on 16/4/19.
//  Copyright © 2016年 Com.Charles. All rights reserved.
//

#import "UIView+Layer.h"

@implementation UIView (Layer)

- (void)setLayerCornerRadius:(CGFloat)cornerRadius
                 borderWidth:(CGFloat)borderWidth
                 borderColor:(UIColor *)borderColor { 
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}

- (void)setLayerBorderColor:(UIColor *)layerBorderColor {
    self.layer.borderColor = layerBorderColor.CGColor;
    [self _config];
}

- (UIColor *)layerBorderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setLayerBorderWidth:(CGFloat)layerBorderWidth {
    self.layer.borderWidth = layerBorderWidth;
    [self _config];
}

- (CGFloat)layerBorderWidth {
    return self.layer.borderWidth;
}

- (void)setLayerCornerRadius:(CGFloat)layerCornerRadius {
    self.layer.cornerRadius = layerCornerRadius;
    [self _config];
}

- (CGFloat)layerCornerRadius {
    return self.layer.cornerRadius;
}

- (void)_config {
    
    self.layer.masksToBounds = YES;
    // 栅格化 - 提高性能
    // 设置栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.shouldRasterize = YES;
}
-(void)setLayerContentsWithImage:(UIImage *)image{
    self.layer.contents = (__bridge id _Nullable)(image.CGImage);//内容模式，类似于UIImageView的contentMode。默认是填充整个区域 kCAGravityResize
    //kCAGravityResizeAspectFill 这个会向左边靠 贴到view的边边上
    //kCAGravityResizeAspect 这个好像就是按比例了 反正是长方形
    self.layer.contentsGravity = kCAGravityResizeAspect;
    
}
@end
