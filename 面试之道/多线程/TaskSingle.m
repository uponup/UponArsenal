//
//  TaskSingle.m
//  面试之道
//
//  Created by 龙格 on 2019/1/31.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "TaskSingle.h"

static TaskSingle *_single;
@implementation TaskSingle

+ (id)instance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _single = [[TaskSingle alloc] init];
    });
    return _single;
}
@end
