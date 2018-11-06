//
//  NSObject+DataSecurity.m
//  yimashuo
//
//  Created by imqiuhang on 15/10/24.
//  Copyright © 2015年 imqiuhang. All rights reserved.
//

#import "NSObject+DataSecurity.h"

@implementation NSObject (DataSecurity)

//请参照.h的文档
- (id)lh_objForKey:(id)key {
    if (!self||![self isKindOfClass:[NSDictionary class]]||!key) {
        return nil;
    }
    return ((NSDictionary *)self)[key];
}

//多级获取数据
- (id)lh_objForKeys:(id)key1, ... {
    
    if (!self||![self isKindOfClass:[NSDictionary class]]||!key1) {
        return nil;
    }
    
    va_list arguments;
    id eachKey;
    id obj;
    if (key1) {
        obj = [self lh_objForKey:key1];
        va_start(arguments, key1);
        while ((eachKey = va_arg(arguments, id))) {
            obj = [obj lh_objForKey:eachKey];
        }
        va_end(arguments);
    }
    
    return obj;
}



- (id)lh_objAtIndex:(NSUInteger)index {
    if (!self||![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    if (index>=[((NSArray *)self) count]) {
        return nil;
    }
    
    return ((NSArray *)self)[index];
}

@end
