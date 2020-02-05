//
//  MCBlock.m
//  面试之道
//
//  Created by 龙格 on 2020/2/4.
//  Copyright © 2020 Paul Gao. All rights reserved.
//

#import "MCBlock.h"

@implementation MCBlock


int global_var = 4;
static int static_global_var = 5;

- (void)method {
    // 基本数据类型的局部变量
    int var = 1;
    // 对象数据类型的局部变量
    __unsafe_unretained id unsafe_obj = nil;
    __strong id strong_obj = nil;
    
    // 局部静态变量
    static int static_var = 3;
    
    void(^Block)(void) = ^{
        NSLog(@"局部变量（基本数据类型）var %d:", var);
        NSLog(@"局部变量（__unsafe_unretained类型）var %@", unsafe_obj);
        NSLog(@"局部变量（__strong类型）var %@", strong_obj);
        NSLog(@"静态变量 %d", static_var);
        NSLog(@"全局变量 %d", global_var);
        NSLog(@"全局静态变量 %d", static_global_var);
    };
    Block();
}

@end
