//
//  Utils.h
//  
//
//  Created by imac on 15-8-13.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



typedef enum{
    UIPanDirectionNone  = 0,
    UIPanDirectionLeft  = 1,
    UIPanDirectionRight = 2,
    UIPanDirectionTop   = 3,
    UIPanDirectionDown  = 4
}UIPanDirection;


@interface Utils : NSObject


//输入提示语
+(void)alertOneTitle:(NSString*)str;
+(void)alertTitle:(NSString*)str WithImg:(UIImage*)img;
+(UIImage *)up:(CGFloat)u down:(CGFloat)d left:(CGFloat)l right:(CGFloat)r imageName:(NSString *)imageName;
#pragma mark - md5
+ (NSString *)md5:(NSString *)str;
+ (NSString *)md5mm:(NSString *)str;
//判断网络
+(BOOL)isNet;
//获取当前时间
+(NSString *)locationString;
//读取城市
+(NSString *)readCity;
//获取应用程序沙盒的Documents目录
+(NSString *)path;
//版本号
+(NSString *)versionnum;
//获得设备型号
+ (NSString *)getCurrentDeviceModel;
//机型描述
+(NSString *)machinedesc;
//封装json
+(NSString *)json:(NSDictionary *)dic;
//dd/mm/yy
+(NSString *)time1String:(NSString *)timestring;
//处理日期
+(NSString *)timeString:(NSString *)timestring;

/**
 获取手机型号

 @return 手机型号
 */
+ (NSString *)iphoneType;

/**
 获取手机IP地址

 @return IP
 */
+ (NSString *)getDeviceIPIpAddresses;

//汉子转拼音
+(NSString*)changeToPingyin:(NSString*)originalStr;

/**
 *  打电话
 *
 *  @param number 号码
 */
+ (void)telephoneWithNumber:(NSString *)number;

/**
 *  发短信
 *
 *  @param number 号码
 */
+ (void)telephoneMessageWithNumber:(NSString *)number;

/**
 *  设定width计算string的高度，
 *
 *  @param string 内容
 *  @param width  宽度
 *  @param font   字体
 *
 *  @return 返回高度值
 */
+ (float)countHeightOfString:(NSString *)string WithWidth:(float)width Font:(UIFont *)font;

+ (float)countHeightOfAttributeString:(NSAttributedString *)string WithWidth:(float)width;

+ (float)countWidthOfString:(NSString *)string WithHeight:(float)height Font:(UIFont *)font;

/**
 *  车牌号正则表达式
 *
 *  @param carNo 输入的车牌号
 *
 *  @return 是否正确
 */
+ (BOOL)validateCarNo:(NSString *)carNo;
/**
 *  密码正则
 *
 *  @param passWord <#passWord description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)validatePassword:(NSString *)passWord;

+ (BOOL)validateUserName:(NSString *)name;
/**
 *  验证手机号码是否正确
 *
 *  @return 正确返回yes
 */
+ (BOOL)validatePhoneNumber:(NSString *)phone;
/**
 *  验证email是否正确
 *
 *  @return 正确返回yes
 */
+ (BOOL)validateEmail:(NSString *)email;
/**
 *  验证邮编是否正确
 *
 *  @return 正确返回yes
 */
+ (BOOL)valiPostCode:(NSString *)postCode;
/**
 *  验证身份证是否正确
 *
 *  @return 正确返回yes
 */
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

+ (BOOL) validateBankCardNumber: (NSString *)bankCardNumber;

+ (BOOL) validateBankCardLastNumber: (NSString *)bankCardNumber;

+ (BOOL) validateCVNCode: (NSString *)cvnCode;

+ (BOOL) validateNickname:(NSString *)nickname;

/**
 *  分割线
 *
 *  @param frame     坐标尺寸
 *  @param lColor    颜色
 *  @param imageName 图片
 *
 *  @return ImageView
 */
+ (UIImageView *)lineWithFrame:(CGRect)frame lineColor:(UIColor *)lColor lineImage:(NSString *)imageName;

/**
 *  获取一个手势的滑动方向
 *
 *  @param translation 滑动的转变坐标
 *
 *  @return 方向 @see UIPanDirection
 */
+ (UIPanDirection)calculatePanDirectionWithTranslation:(CGPoint)translation;


/**
 *  得到照片存储路径
 *
 *  @param filename 照片名
 *
 *  @return 路径
 */
+ (NSString *)documentPath:(NSString *)filename;

/**
 *  根据颜色生成Image
 *
 *  @param color
 *
 *  @return 由color生成的Image
 */
+ (UIImage *)imageFromColor:(UIColor *)color;

/**
 *  把照片存到路径中
 *  @param image 图片
 *  @param aPath 路径
 *
 *  @return 是否成功
 */
+ (BOOL)writeImage:(UIImage*)image toFileAtPath:(NSString*)aPath;
/**
 *  @author imqiuhang
 *
 *  @brief  图片压缩
 *
 *  @param image 原始图片
 *  @param size  压缩后的尺寸
 *
 *  @return 是否压缩成功
 */
+ (UIImage*) originImage:(UIImage *)image scaleToSize:(CGSize)size;
/**
 *  @author imqiuhang
 *
 *  @brief  将一张图片裁剪为圆角
 *
 *  @param image image
 *  @param inset 圆角度
 
 */
+ (UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset ;


/**
 *  @author imqiuhang
 *
 *  @brief  通过hexColor得到一个UIColor
 *
 *  @param color hexColor @example #FFFFFF或者FFFFFF或者0XFFFFFF
 *
 *  @return UIColor alpha为1.f
 */
+ (UIColor *) colorWithHexString: (NSString *)color;

+ (UIColor *) colorWithHexString: (NSString *)color alpha:(float)alpha;


//四舍五入
+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV ;

/**
 *  @author imqiuhang
 *
 *  @brief  把一个HTML的标签转化为富文本
 *
 *  @param html HTML标签
 *
 *  @return 富文本
 */
+ (NSMutableAttributedString*)attributedStringWithHtml:(NSString*)html;


///侏儒13000转成1.3万这样
+ (NSString *)numberCountToStr:(NSInteger)count;

/*!
 *  @author imqiuhang, 15-10-27
 *
 *  @brief  将秒数转化为00：00：00格式
 *
 *  @param seconds   秒
 *  @param separator 分隔符 比如 00'00'00
 *
 *  @return 00：00：00
 */
+ (NSString *)secondsTimeToHHMMSS:(unsigned int)seconds andSeparator:(NSString *)separator;
//00:00
+ (NSString *)secondsTimeToMMSS:(unsigned int)seconds andSeparator:(NSString *)separator;
/**
 *  @author imqiuhang
 *
 *  @brief  得到一个随机不重复的字符串，常用于上传的唯一标示
 *
 *  @param len 长度
 *
 *  @return len长度的随机字符串
 */
+ (NSString *)randomStringWithLength:(int)len;


/**
 *  @author imqiuhang
 *
 *  @brief
 *
 *  @return 最顶层的可见窗口
 */
+ (UIWindow *)currentVisibleWindow;
/**
 *  @author imqiuhang
 *
 *  @brief
 *
 *  @return 最顶层的VC 多用于不知道VC的情况下的push
 */
///!!!!尽量从[QHStaticValueContent currentTopRootViewController] 如果是cell 则用 self.currentTopRootViewController  而少用[QHUtil currentVisibleController]
+ (UIViewController *)currentVisibleController ;

//检查用户是否允许推送
+ (BOOL)pushNotificationsEnabled;

//注册通知
+ (void)resignNotify;

//将服务器返回的时间转化为2015-10-10这样子的简单事件格式字符串
+ (NSString *)defaultSimpleDateFromString:(NSString *)dateString andFormatStr:(NSString *)formatStr;



/**
 解析商品规格JsonString数据

 @param jsonString
 @return string
 */
+ (NSString *)productDecodeInfoWithJsonString:(NSString *)jsonString;


@end
