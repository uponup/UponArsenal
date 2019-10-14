//
//  ViewReusePool.m
//  面试之道
//
//  Created by 龙格 on 2019/2/2.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "ViewReusePool.h"

@interface ViewReusePool()
//等待重用队列
@property (nonatomic, strong) NSMutableSet *waitUsedQueue;
//使用中的重用队列
@property (nonatomic, strong) NSMutableSet *usingQueue;
@end
@implementation ViewReusePool

- (instancetype)init{
    self = [super init];
    if (self) {
        self.waitUsedQueue = [NSMutableSet set];
        self.usingQueue = [NSMutableSet set];
    }
    return self;
}

- (UIView *)dequeueReusableView{
    UIView *view = [self.waitUsedQueue anyObject];
    if (view == nil) {
        return nil;
    }
    [_waitUsedQueue removeObject:view];
    [_usingQueue addObject:view];
    return view;
}
- (void)addReusePool:(UIView *)view{
    if (view == nil) {
        return;
    }
    [_usingQueue addObject:view];
}
- (void)reset{
    UIView *view = nil;
    while ((view = [_usingQueue anyObject])) {
        [_usingQueue removeObject:view];
        [_waitUsedQueue addObject:view];
    }
}
@end
