//
//  Person.m
//  001-demo
//
//  Created by shoule on 2018/8/16.
//  Copyright © 2018年 WT. All rights reserved.
//
//默认(yin'shi)参数 id self,SEL _cmd,
#import "Person.h"
#import <objc/runtime.h>
@implementation Person
//-(void)eat{
//    NSLog(@"吃了");
//}
+(BOOL)resolveInstanceMethod:(SEL)sel{
    
    
    class_addMethod(self, sel, (IMP)eat, "");
    
    return [super resolveInstanceMethod:sel];
}
//方法调用者
//方法编号
void eat(id self,SEL _cmd,NSString * obj){
    
    NSLog(@"eat");
}
@end
