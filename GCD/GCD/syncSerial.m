//
//  syncSerial.m
//  GCD
//
//  Created by shoule on 2018/8/10.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "syncSerial.h"

@implementation syncSerial
-(void)asyn{
    
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_queue_create("gcd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"任务1线程%@",[NSThread currentThread]);
        dispatch_async(queue, ^{
            NSLog(@"任务2线程%@",[NSThread currentThread]);
        });
        NSLog(@"任务3线程%@",[NSThread currentThread]);
    });
    sleep(2);
    NSLog(@"end");
}

-(void)test1{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @synchronized(self){
            NSLog(@"1");
            sleep(2);
            NSLog(@"1 ok");
        }
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @synchronized(self){
            NSLog(@"2");
            sleep(2);
            NSLog(@"2 ok");
        }
    });
}
/*
 
 */
-(void)test2{
    dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
    for (int i=0 ; i<10000; i++) {
        dispatch_async(queue, ^{
            self.name = [NSString stringWithFormat:@"hello-%d",i];
        });
    }
}
-(void)test3{
    _number = 0;
    NSLock *lock = [[NSLock alloc]init];
    dispatch_apply(10000, dispatch_get_global_queue(0, 0), ^(size_t index) {
        [lock lock];
        _number++;
        [lock unlock];
    });
    NSLog(@"%d",_number);
}
@end
