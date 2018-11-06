//
//  Person.m
//  消息发送机制
//
//  Created by shoule on 2018/8/9.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import "Animation.h"
@implementation Person

//+(void)run{
//    NSLog(@"run");
//}
//1.动态方法解析
+(BOOL)resolveInstanceMethod:(SEL)sel{
//    NSLog(@"sel = %@",NSStringFromSelector(sel));
//    if (sel == @selector(run)) {
//        class_addMethod([self class], sel, (IMP)runNew, "v@:");
//        return YES;
//    }
    return [super resolveClassMethod:sel];
}

void runNew(id self,SEL sel){
    NSLog(@"%@ runNew = %@--",self,NSStringFromSelector(sel));
}

-(void)run:(NSString*)rn{
    NSLog(@"run:%@",rn);
}


//2.快速消息转发
-(id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@"sel = %@",NSStringFromSelector(aSelector));
    return [super forwardingTargetForSelector:aSelector];
}
//标准消息转发
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"---%@",anInvocation);
    //拿SEL方法
    SEL sel = [anInvocation selector];
    //转发
    Animation *anim = [Animation new];
    if ([anim respondsToSelector:sel]) {
        //调用这个对象
        [anInvocation invokeWithTarget:anim];
        
    }else{
        [super forwardInvocation:anInvocation];
    }
}
//生成方法签名
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSString *sel = NSStringFromSelector(aSelector);
    if ([sel isEqualToString:@"run"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

//抛出异常
-(void)doesNotRecognizeSelector:(SEL)aSelector{
    NSString *sel = NSStringFromSelector(aSelector);
    NSLog(@"---%@  不存在",sel);
    
}
@end
