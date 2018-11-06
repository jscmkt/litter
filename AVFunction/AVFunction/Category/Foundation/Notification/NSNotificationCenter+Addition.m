//
//  NSNotificationCenter+Addition.m
//  NeiHan
//
//  Created by Charles on 16/3/16.
//  Copyright © 2016年 Com.Charles. All rights reserved.
//

#import "NSNotificationCenter+Addition.h"

@implementation NSNotificationCenter (Addition)

+ (void)postNotification:(NSString *)notiname {
    [self postNotification:notiname object:nil userInfo:nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:notiname object:nil];
}

+ (void)postNotification:(NSString *)notiname object:(id)object {
    [self postNotification:notiname object:object userInfo:nil];
//    if (object == nil) {
//        [self postNotification:notiname];
//    } else {
//        [[NSNotificationCenter defaultCenter] postNotificationName:notiname object:object userInfo:nil];
//    }
}

+ (void)postNotification:(NSString *)notiname object:(id)object userInfo:(NSDictionary *)userInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:notiname object:object userInfo:userInfo];
}

+ (void)removeAllObserverForObj:(id)obj {
    [[NSNotificationCenter defaultCenter] removeObserver:obj];
}

+ (void)addObserver:(id)observer action:(SEL)action name:(NSString *)name {
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:action name:name object:nil];
}

@end
