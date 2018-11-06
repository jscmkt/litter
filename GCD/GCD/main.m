//
//  main.m
//  GCD
//
//  Created by shoule on 2018/8/10.
//  Copyright © 2018年 WT. All rights reserved.
//
/**
 线程安全：内存数据被多个线程读取之后，出现的结果如果是可预见的，那么就是线程安全，如果是不可预见的，那么就是我线程不安全
 线程锁：就是保证线程安全  原理：确保读取数据的时候，只有一条线程在操作
 */
#import <Foundation/Foundation.h>
#import "syncSerial.h"
/**
 主队列中，异步添加任务，不会开辟新线程
 */
void mianQue(){
    dispatch_queue_t mianq = dispatch_get_main_queue();
    dispatch_async(mianq, ^{
        NSLog(@"1");
    });
    NSLog(@"end");
    
}
/*
 死锁：2任务相互等待，block
 
 */
void asySerSy(){
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_queue_create("gcd", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"任务1线程%@",[NSThread currentThread]);
        dispatch_sync(queue, ^{
            NSLog(@"任务2线程%@",[NSThread currentThread]);
        });
        NSLog(@"任务3线程%@",[NSThread currentThread]);
    });
    NSLog(@"end");
    sleep(2);
}
void sy(){
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_queue_create("gcd", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"任务1线程%@",[NSThread currentThread]);
        dispatch_async(queue, ^{
            NSLog(@"任务2线程%@",[NSThread currentThread]);
        });
        NSLog(@"任务3线程%@",[NSThread currentThread]);
    });
    NSLog(@"end");
    sleep(2);
}
/**
 开辟新线程：1，异步；2.如果实在串行队列只会开辟一条；3.并发队列中，开辟的线程数量有限
 任务：block里main的代码块
 */
void as(){
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_queue_create("gcd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"任务1线程%@",[NSThread currentThread]);
        dispatch_sync(queue, ^{
            NSLog(@"任务2线程%@",[NSThread currentThread]);
        });
        NSLog(@"任务3线程%@",[NSThread currentThread]);
    });
    NSLog(@"end");
    sleep(2);
}
/*
 并发队列中的异步一定会开辟新线程？ 不一定
 开辟线程：1.占内存，子线程(512kb) 主线程(1M),2.线程越多，cpu的执行效率会变低
 内核：3-6条
 */
void test(){
    dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
    for (int i=0; i<100; i++) {
        
        dispatch_async(queue, ^{
            NSLog(@"任务%d线程%@",i,[NSThread currentThread]);
        });
    }
//    sleep(5);
}
//并发队列中的异步一定会开辟新线程
void asyncConcurrent(){
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_queue_create("gcd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"任务1线程%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务2线程%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务3线程%@",[NSThread currentThread]);
    });
//    sleep(2);
    NSLog(@"end");
}
/**
 并发队列中的任务一定会并发执行吗？不一定，如果是同步，不会开辟新线程，那么按顺序执行，如果是异步，那么就是真正的并发
 */
void syncConcurrent(){
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_queue_create("gcd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        NSLog(@"任务1线程%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务2线程%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3线程%@",[NSThread currentThread]);
    });
    NSLog(@"end");
}
/*
 同步：1.不会开辟新线程
 2.会阻塞当前线程
 异步：1.会开辟新线程，在串行中多个异步只会开辟一个线程
 2.不会阻塞当前线程
 */
void syncSerial1(){
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_queue_create("gcd", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        NSLog(@"任务1");
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务2");
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3");
    });
    NSLog(@"end");
}
void asyncSerial(){
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_queue_create("gcd", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"1线程%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2线程%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"3线程%@",[NSThread currentThread]);
    });
//    sleep(2);
    NSLog(@"end");
}
void applay(){
    
    dispatch_queue_t queue = dispatch_queue_create("gcd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_apply(100, queue, ^(size_t index) {
        NSLog(@"%@",[NSThread currentThread]);
    });
    NSLog(@"end");
}
void group(){
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"1");
        });
        dispatch_group_leave(group);
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2");
        dispatch_group_leave(group);
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"3");
        dispatch_group_leave(group);
    });
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"end");
    });
}
void barrier(){
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"1");
    });
    dispatch_async(queue, ^{
        NSLog(@"2");
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"barrier");
    });
    dispatch_async(queue, ^{
        NSLog(@"3");
    });
    dispatch_async(queue, ^{
        NSLog(@"4");
    });
}
void test1(){
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        @synchronized(){
            NSLog(@"1");
            sleep(2);
            NSLog(@"1 ok");
//        }
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2");
        sleep(2);
        NSLog(@"2 ok");
    });
}
void semaphore(){
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"1");
        sleep(2);
        NSLog(@"1 ok");
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"2");
        sleep(2);
        NSLog(@"2 ok");
        dispatch_semaphore_signal(semaphore);
    });
    
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
//        asyncSerial();
//        asyncConcurrent();
//        asyncConcurrentAsyn();
//        asyncSerial();
//        test1();
//        syncSerial *sy = [syncSerial new];
//        [sy test3];
        semaphore();
        while (1) {
            
            sleep(2);
        }

    }
    return 0;
}
