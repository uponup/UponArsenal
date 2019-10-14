//
//  CustomJSObject.m
//  面试之道
//
//  Created by 龙格 on 2019/1/8.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "CustomJSObject.h"

@interface CustomJSObject()
@property (nonatomic, copy) JSObjectBlock successBlock;
@property (nonatomic, copy) JSObjectBlock failBlock;
@property (nonatomic, strong) NSMutableArray *actionArray;
@end

@implementation CustomJSObject

- (id)initWithSuccessCallback:(JSObjectBlock)success failCallback:(JSObjectBlock)fail{
    self = [super init];
    if (self) {
        self.successBlock = success;
        self.failBlock = fail;
        self.actionArray = [NSMutableArray array];
    }
    return self;
}
- (void)jsCallMethod {
    if (![self.actionArray containsObject:@"jsCallMethod"]) {
        [self addToTimerAction:@"jsCallMethod"];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.successBlock) {
                self.successBlock(@{@"jsCallMethod":@""});
            }
        });
    }
}

- (void)jsCallMethodWithParam:(NSString *)param {
    if (![self.actionArray containsObject:@"jsCallMethodWithParam"]) {
        [self addToTimerAction:@"jsCallMethodWithParam"];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.successBlock) {
                NSDictionary *dic = @{@"param": param};
                self.successBlock(@{@"jsCallMethodWithParam":dic});
            }
        });
    }
}

- (void)jsCallMethodWithParam:(NSString *)param AndParamTwo:(NSString *)param2 {
    if (![self.actionArray containsObject:@"jsCallMethodWithTwoParam"]) {
        [self addToTimerAction:@"jsCallMethodWithTwoParam"];
        if (self.successBlock) {
            NSDictionary *dic = @{@"param1": param, @"param2": param2};
            self.successBlock(@{@"jsCallMethodWithTwoParam":dic});
        }
    };
}

- (void)sendValueToHtml{
    if (![self.actionArray containsObject:@"sendValueToHtml"]) {
        [self addToTimerAction:@"sendValueToHtml"];
        if (self.successBlock) {
            self.successBlock(@{@"OcCallJS": @""});
        }
    }
}
#pragma mark - Private Method
- (void)addToTimerAction:(NSString *)action{
    [self.actionArray addObject:action];
    __block NSInteger seconds = 0;
    dispatch_queue_t queue = dispatch_get_main_queue();
    __block dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(1 * NSEC_PER_SEC);
    dispatch_source_set_timer(timer, start, interval, 0);
    dispatch_source_set_event_handler(timer, ^{
        seconds++;
        if (seconds == 1) {
            dispatch_cancel(timer);
            [self.actionArray removeObject:action];
        }
    });
    // 启动定时器
    dispatch_resume(timer);
}
@end
