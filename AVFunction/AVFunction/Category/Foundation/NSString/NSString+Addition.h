//
//  NSString+Addition.h
//  NeiHan
//
//  Created by Charles on 16/9/1.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (Addition) 

///去除空格判断是否为空
- (BOOL)isNotEmptyCtg;
///不去除空格判断是否为空=
- (BOOL)isNotEmptyWithSpace;

///符号成套删除 可用于去除带有xml标记 如<color>
- (NSString*)stringByDeleteSignForm:(NSString *)aLeftSign
                       andRightSign:(NSString *)aRightSign;


- (NSString*)stringByReplacingSignForm:(NSString *)aLeftSign
                          andRightSign:(NSString *)aRightSign
                       andReplacingStr:(NSString*)aReplacingStr;
/**
 *  无空格和换行的字符串 
 */
- (NSString *)noWhiteSpaceString;


/**
 行间距富文本

 @param lineSpacing 间距

 @return NSAttributedString
 */
- (NSAttributedString *)attributedStringWithLineSpacing:(float)lineSpacing;
+ (NSAttributedString *)attributedStringWithLineSpacing:(float)lineSpacing andString:(NSString *)string;

+ (NSAttributedString *)deleteLineString:(NSString *)string font:(UIFont *)font color:(UIColor *)color;

/** 计算字体大小和换行需要最大换行距离*/
- (CGSize)sizeWithText:(UIFont *)font maxW:(CGFloat)maxW;

/** 计算字体大小和换行*/
- (CGSize)sizeWithText:(UIFont *)font;

/**
 *  计算当前文件\文件夹的内容大小
 */
- (NSInteger)fileSize;
/**
 *  判断手机号
 */
- (BOOL)isPhoneNumber;
/**
 *  判断手机号
 */
- (BOOL)isValidateMobile:(NSString *)mobileNum;
/**
 *  判断邮箱
 */
-(BOOL)isEmailWithString:(NSString *)str;

-(BOOL)isGloabelNumberWithString:(NSString *)str;

/**
 返回处理过的字符串，只保留小数点后两位，结尾0省略
 */
- (instancetype)dealedPriceString;
/**
 * 判断中文和英文字符串的长度
 */
- (int)convertToInt:(NSString*)strtemp;

//- (NSString *)convertTimesTampWithDateFormat:(NSString *)dateFormat;



@end
