//
//  syncSerial.h
//  GCD
//
//  Created by shoule on 2018/8/10.
//  Copyright © 2018年 WT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface syncSerial : NSObject
/*
 atomic：原子的(set、get上加锁的)耗性能的
 nonatomic:非原子的
 why 不用atomic？：很多情况下，除了set、get操作之外，它并不能保证线程安全，且耗性能
 */
@property(nonatomic,copy)NSString *name;
@property(atomic,assign)int number;
-(void)asyn;
-(void)test1;
-(void)test2;
-(void)test3;
@end
