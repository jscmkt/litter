//
//  Utils.m
//
//
//  Created by imac on 15-8-13.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "Utils.h"
#import <sys/utsname.h>
#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#import <arpa/inet.h>
#import <UserNotifications/UserNotifications.h>
#import "iToast.h"
#import "Reachability.h"
#import <sys/sysctl.h>
#import "sys/utsname.h"
#import "SAMKeychain.h"
#import <CommonCrypto/CommonDigest.h>
@implementation Utils
//输入提示语
+(void)alertOneTitle:(NSString*)str{
    //    NSString* str2 = [NSString stringWithFormat:@""];
    iToast* toast = [iToast makeText:str];
    //    [[toast theSettings]setImage:[UIImage imageNamed:@"ico-address-note"] withLocation:iToastImageLocationTop forType:iToastTypeNotice];
    [toast setDuration:iToastDurationShort];
    [toast setGravity:iToastGravityCenter];
    //    [toast setGravity:iToastGravityCenter offsetLeft:200 offsetTop:5];
    iToastSettings* theSet = [toast theSettings];
    theSet.cornerRadius = 2.f;
    theSet.fontSize = 14.f;
    [toast show];
    
}

//带图片中间显示的提示框
+(void)alertTitle:(NSString*)str WithImg:(UIImage*)img{
    iToast *toast = [iToast makeText:str];
    [toast setFontSize:14];
    [toast setDuration:iToastDurationNormal];
    [toast setGravity:iToastGravityCenter];
    iToastSettings* theSet = [toast theSettings];
    theSet.cornerRadius = 2.f;
    theSet.fontSize = 14.f;
    [theSet setImage:img withLocation:(iToastImageLocationTop) forType:(iToastTypeInfo)];
    [toast show:(iToastTypeInfo)];
}
+(NSDictionary *)json1:(NSDictionary *)dic
{
    
    //         NSArray *allkeys = [params allKeys];
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSDictionary *dic1=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];;
    //    NSLog(@"%@",dic1);
    
    return dic1;
}
+(UIImage *)up:(CGFloat)u down:(CGFloat)d left:(CGFloat)l right:(CGFloat)r imageName:(NSString *)imageName{
    UIImage* resizableImage = [[UIImage imageNamed:imageName]
                               resizableImageWithCapInsets:UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f) // 上，下，左，右 留边尺寸
                               ];
    
    return resizableImage;
    
}


+(BOOL)isNet
{
    
    Reachability *re = [Reachability reachabilityForInternetConnection];
    if ([re currentReachabilityStatus] ==NotReachable) {
        return NO;
    }else if ([re currentReachabilityStatus] ==ReachableViaWiFi)
    {
        //        NSLog(@"当前wifi连接");
        return YES;
    }else{
        //        NSLog(@"wwan(3g)");
        return YES;
    }
    
    
    
}
+(NSString *)time1String:(NSString *)timestring{
    //    if (isIOS8) {
    //
    //    }else{
    //        NSDateFormatter *format=[[NSDateFormatter alloc]init];
    //        [format setDateFormat:@"yyyy/MM/dd hh:mm:ss"];
    //        NSDate *date=[format dateFromString:timestring];
    //        [format setDateFormat:@"dd/MM/yyyy"];
    //
    //        return [format stringFromDate:date];
    //        //        NSDateFormatter *format=[[NSDateFormatter alloc]init];
    //        //    [format setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    //        //        NSDate *date=[format dateFromString:timestring];
    //        //
    //        //        NSLog(@"%@",date);
    //        //        return [format stringFromDate:date];
    //    }
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *date=[format dateFromString:timestring];
    [format setDateFormat:@"yyyy/MM/dd"];
    
    return [format stringFromDate:date];
}


+ (NSString *)md5:(NSString *)str {
    
    
    
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
        
        
        
    }
    
    return [hash lowercaseString];
    
    
    
}
+ (NSString *)md5mm:(NSString *)str {
    
    
    
    const char *cStr = [str UTF8String];
    unsigned char result[64];
    CC_MD5(cStr, strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 64; i++)
    {
        [hash appendFormat:@"%0X", result[i]];
    }
    return [hash lowercaseString];
    
    
}

//获取当前时间
+(NSString *)locationString
{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}

//返回文字
+(NSString*)returnText:(NSString*)text locale:(NSString*)localeText{
    
    NSString* returnText=(text==nil||[text isEqualToString:@""])?localeText:text;
    return returnText;
}



//读取城市
+(NSString *)readCity{
    NSString*city=[[NSUserDefaults standardUserDefaults]objectForKey:@"city"];
    if (city==nil||[city isEqualToString:@""]) {
        city=@"上海";
    }
    return city;
    
}

//获取应用程序沙盒的Documents目录
+(NSString *)path
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    return plistPath1;
}

//版本号
+(NSString *)versionnum
{
    return  [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
}

//获得设备型号
+ (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    //    platform =@"i3821216";
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241－A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303－A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387－A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429－A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456－A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507－A1516－A1526－A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453－A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457－A1518－A1528－A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522－A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549－A1586)";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421－A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219－A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    
    if ([platform isEqualToString:@"iPad6,1"])   return @"iPadPro";
    if ([platform isEqualToString:@"iPad6,2"])   return @"iPadPro";
    if ([platform isEqualToString:@"iPad6,3"])   return @"iPadPro";
    
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPad Air2";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPad Air2";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPad Air2";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPad Air2";
    if ([platform isEqualToString:@"iPad5,5"])   return @"iPad Air2";
    if ([platform isEqualToString:@"iPad5,6"])   return @"iPad Air2";
    
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    //    NSArray *array = [platform componentsSeparatedByString:@","];
    //    NSString*str=array[0];
    if (!platform) {
        platform=@"";
    }
    return platform;
}
//处理时间转化
+(NSString *)timeString:(NSString *)timestring{
    if (isIOS8) {
        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSDate *date=[format dateFromString:timestring];
        [format setDateFormat:@"yyyy-MM-dd"];
        
        return [format stringFromDate:date];
        
    }else{
        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy/MM/dd h:mm:ss"];
        NSDate *date=[format dateFromString:timestring];
        [format setDateFormat:@"yyyy-MM-dd"];
        
        return [format stringFromDate:date];
        //        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        //    [format setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        //        NSDate *date=[format dateFromString:timestring];
        //
        //        NSLog(@"%@",date);
        //        return [format stringFromDate:date];
    }
    
}

//机型描述
+(NSString *)machinedesc{
    NSString *identifierStr;
    
    
    //从钥匙串读取UUID：
    identifierStr=[SAMKeychain passwordForService:@"com.bestcake.bsk0001"account:@"user"];
    if (!identifierStr||[identifierStr isEqualToString:@""]) {
        identifierStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        //        NSMutableDictionary*dic=[NSMutableDictionary dictionary];
        //        [dic setNewObject:identifierStr forKey:@"identifierStr"];
        [SAMKeychain setPassword: [NSString stringWithFormat:@"%@", identifierStr]
                      forService:@"com.bestcake.bsk0001"account:@"user"];
    }
    //    **注意: setPassword和passwordForSevice方法中的**services 和 accounts 参数应该是一致的。
    NSString* deviceName = [self getCurrentDeviceModel];
    NSString* phoneVersion = [NSString stringWithFormat:@"-%@-%@",[[UIDevice currentDevice] systemVersion],identifierStr];
    return [deviceName stringByAppendingString:phoneVersion];
}
//封装json
+(NSString *)json:(NSDictionary *)dic
{
    NSMutableString *paramsString;
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:dic
                                                     options:NSJSONWritingPrettyPrinted
                                                       error:nil];
    paramsString = [[NSMutableString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSString *str = [paramsString stringByReplacingOccurrencesOfString: @"\n" withString:@""];
    //    NSString *json = [str stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    return str;
}
+(NSString*)changeToPingyin:(NSString*)originalStr{
    NSMutableString *ms = [[NSMutableString alloc] initWithString:originalStr];
    if ([originalStr length]) {
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
        }
    }
    return ms;
}


+ (void)telephoneWithNumber:(NSString *)number {
    if (number.length) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",number];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

    }
}

+ (void)telephoneMessageWithNumber:(NSString *)number {
    if (number.length) {
        NSMutableString *str= [[NSMutableString alloc] initWithFormat:@"sms://%@",number];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
    }
}

+ (BOOL)validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}

//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9-/:;\\(\\)¥&@\"\?\'\\\\.,!#%\\^*+={}\\[\\]_\\|~<>\\$€£•]{6,18}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

+ (UILabel *)lineWithFrame:(CGRect)fram color:(UIColor *)color {
    UILabel *line = [[UILabel alloc] initWithFrame:fram];
    
    if (color) {
        line.backgroundColor = color;
    } else
        line.backgroundColor = HEXCOLOR(0xdedede);
    
    return line;
    
}



+ (float)countHeightOfString:(NSString *)string WithWidth:(float)width Font:(UIFont *)font {
    if (![string isNotEmptyCtg]) {
        string = @"";
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
    
    CGSize constraintSize = CGSizeMake(width, MAXFLOAT);
    CGSize labelSize = [string sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:NSLineBreakByCharWrapping];
    return labelSize.height;
}


+ (float)countHeightOfAttributeString:(NSAttributedString *)string WithWidth:(float)width {
    UITextView * label = [[UITextView alloc] init];
    label.jk_width = width;
    [label setAttributedText:string];
    
    CGSize size = [label sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
}

+ (float)countWidthOfString:(NSString *)string WithHeight:(float)height Font:(UIFont *)font {
    if (![string isNotEmptyCtg]) {
        string = @"";
    }
    CGSize constraintSize = CGSizeMake(MAXFLOAT, height);
    CGSize labelSize = [string sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
    return labelSize.width;
#pragma clang diagnostic pop
}


+ (UIImageView *)lineWithFrame:(CGRect)frame lineColor:(UIColor *)lColor lineImage:(NSString *)imageName
{
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:frame];
    if (lColor) {
        lineImageView.backgroundColor = lColor;
    } else
        lineImageView.backgroundColor = COLOR_UNDER_LINE;
    if (imageName) {
        lineImageView.image = [UIImage imageNamed:imageName];
    }
    
    return lineImageView;
}

+ (UIPanDirection)calculatePanDirectionWithTranslation:(CGPoint)translation {
    if (fabs(translation.x/translation.y)>5.0f) {
        if (translation.x>0) {
            return UIPanDirectionRight;
        }else {
            return UIPanDirectionLeft;
        }
    }else {
        if (translation.y>0) {
            return UIPanDirectionTop;
        }else {
            return UIPanDirectionDown;
        }
    }
}

+ (BOOL)validatePhoneNumber:(NSString *)phone {
    if ([phone length]!=11) {
        return NO;
    }
    NSString *regExStr = @"^1\\d{10}$";
    NSError *error = NULL;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regExStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    
    long result = [regex numberOfMatchesInString:phone options:0 range:NSMakeRange(0, [phone length])];
    if(result>0) {
        return YES;
    }else {
        return NO;
    }
    
}

+ (BOOL)validateEmail:(NSString *)email {
    
    NSString *regExStr = @"^\\w*@\\w*\\.\\w*$";
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regExStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    long result = [regex numberOfMatchesInString:email options:0 range:NSMakeRange(0, [email length])];
    if(result>0){
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)valiPostCode:(NSString *)postCode {
    
    const char *cvalue = [postCode UTF8String];
    int len = (int)strlen(cvalue);
    if (len != 6) {
        return NO;
    }
    for (int i = 0; i < len; i++) {
        if (!(cvalue[i] >= '0' && cvalue[i] <= '9')) {
            return NO;
        }
    }
    return YES;
}


//身份证号
+ (BOOL)validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//银行卡
+ (BOOL)validateBankCardNumber: (NSString *)bankCardNumber
{
    BOOL flag;
    if (bankCardNumber.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{15,30})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:bankCardNumber];
}
//银行卡后四位
+ (BOOL)validateBankCardLastNumber: (NSString *)bankCardNumber
{
    BOOL flag;
    if (bankCardNumber.length != 4) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{4})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:bankCardNumber];
}
//CVN
+ (BOOL)validateCVNCode: (NSString *)cvnCode
{
    BOOL flag;
    if (cvnCode.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{3})";
    NSPredicate *cvnCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [cvnCodePredicate evaluateWithObject:cvnCode];
}

//用户名
+ (BOOL)validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:name];
}

//昵称
+ (BOOL)validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{1,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}



+ (NSString *)documentPath:(NSString *)filename{
    NSString *result=nil;
    NSArray *folders = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsFolder = [folders objectAtIndex:0];
    result = [documentsFolder stringByAppendingPathComponent:filename];
    
    return result;
}

+ (UIImage *)imageFromColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, 90, 30);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}



+ (UIImage *)getImage:(NSString *)imageName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory,                                                                          NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath2 = [documentsDirectory stringByAppendingPathComponent:imageName];
    UIImage *img = [UIImage imageWithContentsOfFile:filePath2];
    return img;
}

+ (UIImage*) originImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext(); UIGraphicsEndImageContext();
    return scaledImage;
}

+ (UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset {
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

+ (BOOL)writeImage:(UIImage*)image toFileAtPath:(NSString*)aPath {
    if ((image == nil) || (aPath == nil) || ([aPath isEqualToString:@""]))
        return NO;
    @try {
        NSData *imageData = nil;
        imageData = UIImagePNGRepresentation(image);
        if ((imageData == nil) || ([imageData length] <= 0))
            return NO;
        
        [imageData writeToFile:aPath atomically:YES];
        return YES;
    }
    @catch (NSException *e) {
        MSLog(@"保存图片失败");
    }
    return NO;
}

+ (NSString *)randomStringWithLength:(int)len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    return randomString;
}

+ (UIColor *) colorWithHexString: (NSString *)color{
    return [Utils colorWithHexString:color alpha:1.f];
}

+ (UIColor *) colorWithHexString: (NSString *)color alpha:(float)alpha{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6) {
        MSLog(@"输入的16进制有误，不足6位！");
        return [UIColor clearColor];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}

+ (NSString *)numberCountToStr:(NSInteger)count {
    
    if (count<=0) {
        return @"0";
    }
    
    if (count<10000) {
        return [NSString stringWithFormat:@"%li",(long)count];
    }
    
    
    float num = count/10000.f;
    double zhengshu = 0.00f;
    double yushu =   modf(num,&zhengshu);
    
    return yushu>0.1? [NSString stringWithFormat:@"%.1f万",count/10000.0f]:[NSString stringWithFormat:@"%i万",(int)count/10000];
}

+ (NSString *)secondsTimeToHHMMSS:(unsigned int)seconds andSeparator:(NSString *)separator {
    int h = seconds/3600;
    int m = (seconds - h*3600)/60;
    int s = seconds - h*3600 - m*60;
    
    NSString *sh = [NSString stringWithFormat:@"%i",h];
    NSString *sm = [NSString stringWithFormat:@"%i",m];
    NSString *ss = [NSString stringWithFormat:@"%i",s];
    
    sh = sh.length<=1?[NSString stringWithFormat:@"0%@",sh]:sh;
    sm = sm.length<=1?[NSString stringWithFormat:@"0%@",sm]:sm;
    ss = ss.length<=1?[NSString stringWithFormat:@"0%@",ss]:ss;
    
    return [@[sh,sm,ss] componentsJoinedByString:separator];
}

+ (NSString *)secondsTimeToMMSS:(unsigned int)seconds andSeparator:(NSString *)separator {
    
    int m = (seconds)/60;
    int s = seconds - m*60;
    
    NSString *sm = [NSString stringWithFormat:@"%i",m];
    NSString *ss = [NSString stringWithFormat:@"%i",s];
    
    sm = sm.length<=1?[NSString stringWithFormat:@"0%@",sm]:sm;
    ss = ss.length<=1?[NSString stringWithFormat:@"0%@",ss]:ss;
    
    return [@[sm,ss] componentsJoinedByString:separator];
}

+ (NSMutableAttributedString*)attributedStringWithHtml:(NSString*)html {
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    return attrStr;
}


+ (UIWindow *)currentVisibleWindow {
    NSEnumerator *frontToBackWindows =
    [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            return window;
        }
    }
    return [[[UIApplication sharedApplication] delegate] window];
}

+ (UIViewController *)currentVisibleController {
    UIViewController *topController =
    [Utils currentVisibleWindow].rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    return topController;
}

+ (BOOL)pushNotificationsEnabled {
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(currentUserNotificationSettings)]) {
        UIUserNotificationType types = [[[UIApplication sharedApplication] currentUserNotificationSettings] types];
        return (types & UIUserNotificationTypeAlert);
    }
    else {
        UIRemoteNotificationType types = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        return (types & UIRemoteNotificationTypeAlert);
    }
}


+ (void)resignNotify {
    
    //>>>>>>>>>>>>>>>notify
    
    if (isIOS8) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:
                                                UIUserNotificationTypeAlert   //弹出框
                                                | UIUserNotificationTypeBadge //状态栏
                                                | UIUserNotificationTypeSound //声音
                                                
                                                categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }else {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded");
            }
        }];

    }
    
}


+ (NSString *)defaultSimpleDateFromString:(NSString *)dateString andFormatStr:(NSString *)formatStr {
    if (![dateString isNotEmptyCtg]) {
        return @"";
    }
    
    dateString = [NSString stringWithFormat:@"%@",dateString];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateString];
    if (date) {
        [formatter setDateFormat:formatStr];
        return  [formatter stringFromDate:date];
    }
    return @"";
}

+ (NSString *)iphoneType {
    
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    
    // iPod Touch
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPod7,1"]) return @"iPod Touch 6G";
    
    
    // iPad
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    
    
    // iPad Air
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad Mini 2G";
    
    
    // iPad Mini
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini2";
    
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini2";
    
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2";
    
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPad Mini 3";
    
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPad Mini 3";
    
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPad Mini 3";
    
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPad Mini 4";
    
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPad Mini 4";
    
    
    // iPhone Simulator
    if ([platform isEqualToString:@"i386"])    return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"])  return @"iPhone Simulator";
    
    return platform;
    
}

+ (NSString *)getDeviceIPIpAddresses

{
    
    int sockfd =socket(AF_INET,SOCK_DGRAM, 0);
    
    NSMutableArray *ips = [NSMutableArray array];

    int BUFFERSIZE =4096;
    
    struct ifconf ifc;
    
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    
    ifc.ifc_len = BUFFERSIZE;
    
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd,SIOCGIFCONF, &ifc) >= 0){
        
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            
            ifr = (struct ifreq *)ptr;
            
            int len =sizeof(struct sockaddr);
            
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            
            ptr += sizeof(ifr->ifr_name) + len;
            
            if (ifr->ifr_addr.sa_family !=AF_INET) continue;
            
            if ((cptr = (char *)strchr(ifr->ifr_name,':')) != NULL) *cptr =0;
            
            if (strncmp(lastname, ifr->ifr_name,IFNAMSIZ) == 0)continue;
            
            memcpy(lastname, ifr->ifr_name,IFNAMSIZ);
            
            ifrcopy = *ifr;
            
            ioctl(sockfd,SIOCGIFFLAGS, &ifrcopy);
            
            if ((ifrcopy.ifr_flags &IFF_UP) == 0)continue;
            
            NSString *ip = [NSString stringWithFormat:@"%s",inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    
    close(sockfd);
    
    NSString *deviceIP =@"";
    
    for (int i=0; i < ips.count; i++)
    {
        if (ips.count >0)
        {
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    MSLog(@"deviceIP========%@",deviceIP);
    return deviceIP;
    
}

+ (NSString *)productDecodeInfoWithJsonString:(NSString *)jsonString {
    if (!jsonString) {
        return @"";
    }
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSString *classString = [dict valueForKey:@"speciality"];
    
    NSArray *keys1 = [classString componentsSeparatedByString:@","];
    
    NSArray *keys2 = nil;;
    NSArray *keys3 = nil;
    for (int i=0; i<keys1.count; i++) {
        NSArray *ar = [[keys1 objectAtIndex:i] componentsSeparatedByString:@"-"];
        if (i) {
            keys3 = ar;
        } else {
            keys2 = ar;
        }
    }
    
    if (!keys2 && !keys3) {
        return @"";
    }
    
    NSString *string;
    
    string = [NSString stringWithFormat:@"%@%@：",[keys2 objectAtIndex:1],[keys3 objectAtIndex:1]];
    string = [string stringByAppendingString:[NSString stringWithFormat:@"%@ %@",dict[[keys2 objectAtIndex:0]],dict[[keys3 objectAtIndex:0]]]];
    
    NSString *str1 = [keys2 objectAtIndex:1];
    NSString *str2 = [keys3 objectAtIndex:1];
    NSString *str3 = dict[[keys2 objectAtIndex:0]];
    NSString *str4 = dict[[keys3 objectAtIndex:0]];
    
    NSString *resut1;
    NSString *resut2;
    
    resut1 = str1 ? str1 : @"";
    resut1 = [NSString stringWithFormat:@"%@%@",resut1,str2 ? str2 : @""];
    
    resut2 = str3 ? str3 : @"";
    resut2 = [NSString stringWithFormat:@"%@%@",resut2,str4 ? str4 : @""];
    
    if (resut1 && resut2) {
        return [NSString stringWithFormat:@"%@：%@",resut1,resut2];
    } else {
        return @"";
    }
}


@end
