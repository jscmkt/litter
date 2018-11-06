//
//  NSKVONOtyfing_Person.m
//  001-demo
//
//  Created by shoule on 2018/8/17.
//  Copyright © 2018年 WT. All rights reserved.
//

#import "NSKVONOtyfing_Person.h"

@implementation NSKVONOtyfing_Person
-(void)setName:(NSString *)name{
    [self willChangeValueForKey:@"name"];
    [super setName:name];
    [self didChangeValueForKey:@"name"];
}
@end
