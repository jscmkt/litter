//
//  NSURL+url.m
//  001-demo
//
//  Created by shoule on 2018/8/17.
//  Copyright © 2018年 WT. All rights reserved.
//
//二进制 --> 装载 --> 内存
//cpu
#import "NSURL+url.h"
#import <objc/runtime.h>
@implementation NSURL (url)

//预加载
+(void)load{
    //交换放方法的调用顺序
    Method urlWithStr = class_getClassMethod(self, @selector(URLWithString:));
    Method urlWithJSCStr = class_getClassMethod(self, @selector(JSC_URLWithString:));
    
    method_exchangeImplementations(urlWithStr, urlWithJSCStr);
}
//类似方法交换这样的高级功能的时候写上注释
+(instancetype)JSC_URLWithString:(NSString *)URLString{
    NSURL *url = [NSURL JSC_URLWithString:URLString];
    if (url == nil) {
        NSLog(@"nil");
        
        
    }
    
    return url;
}
@end
