//
//  main.m
//  消息发送机制
//
//  Created by shoule on 2018/8/9.
//  Copyright © 2018年 WT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        Person *person = ((Person * (*)(id,SEL))objc_msgSend)((id)[Person class],@selector(alloc));
//        person = ((Person * (*)(id,SEL))objc_msgSend)((id)person,@selector(init));
//        ((Person * (*)(id,SEL))objc_msgSend)((id)person,@selector(run));
        Person *person = [Person new];
        [person performSelector:@selector(run)];
    }
    return 0;
}
