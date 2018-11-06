//
//  NSObject+JSCKVO.h
//  001-demo
//
//  Created by shoule on 2018/8/17.
//  Copyright © 2018年 WT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JSCKVO)
-(void)J_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
@end
