//
//  NSObject+JSCKVO.m
//  001-demo
//
//  Created by shoule on 2018/8/17.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "NSObject+JSCKVO.h"
#import <objc/message.h>
@implementation NSObject (JSCKVO)
-(void)J_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    //
    NSString *oldName = NSStringFromClass(self.class);
    NSString *newName = [@"JKVO_" stringByAppendingString:oldName];
    Class newClass = objc_allocateClassPair(self.class, newName.UTF8String, 0);
    objc_registerClassPair(newClass);//注册该类
    object_setClass(self, newClass);
    
    //动态添加方法
    class_addMethod(newClass, @selector(setName:), (IMP)setName, "v@:@");
}
void setName(id self,SEL _cmd,NSString *newName){
    NSLog(@"拿到了%@",newName);
}
@end
