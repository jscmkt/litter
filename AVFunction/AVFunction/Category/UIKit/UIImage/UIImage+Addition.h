//
//  UIImage+Addition.h
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Addition)

+ (UIImage *)circleImageWithname:(NSString *)name
                     borderWidth:(CGFloat)borderWidth
                     borderColor:(UIColor *)borderColor;

/**
 *  保持宽高比设置图片在多大区域显示
 */
- (UIImage *)sourceImage:(UIImage *)sourceImage
              targetSize:(CGSize)targetSize;

/**
 *  指定宽度按比例缩放
 */
- (UIImage *)sourceImage:(UIImage *)sourceImage
             targetWidth:(CGFloat)targetWidth;

/**
 *  等比例缩放
 */
- (UIImage *)sourceImage:(UIImage *)sourceImage
                   scale:(CGFloat)scale;


+ (UIImage *)resizableImageWithImageName:(NSString *)imageName;



/** 压缩图片到指定的物理大小*/
- (NSData *)compressImageDataWithMaxLimit:(CGFloat)maxLimit;

- (UIImage *)compressImageWithMaxLimit:(CGFloat)maxLimit;


/**
 *  图片的旋转
 *
 *  
 *  @param orientation 方向
 *
 *  @return 旋转后的图片
 */
- (UIImage *)imageWithOrientation:(UIImageOrientation)orientation;

/**
 *  获取图片颜色
 *
 *  @param point 坐标点
 *
 *  @return color
 */
- (UIColor *) getPixelColorAtLocation:(CGPoint)point;

- (UIImage *)placeholderImageWithSize:(CGSize)size;

@end
