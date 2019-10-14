//
//  CustomOperation.m
//  面试之道
//
//  Created by 龙格 on 2019/1/31.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "CustomOperation.h"

@interface CustomOperation ()
@property (nonatomic, copy) NSString *operationName;
@property (nonatomic, assign) BOOL isOver;
@end
@implementation CustomOperation

- (instancetype)initWithName:(NSString *)name{
    if (self = [super init]) {
        self.isOver = NO;
        self.operationName = name;
    }
    return self;
}

- (void)main{
//    for (NSInteger i=0; i<3; i++) {
//        NSLog(@"当前线程是：%@", self.operationName);
//        sleep(1);
//    }
    
    NSLog(@"开始执行异步操作：%@", self.operationName);
    [self loadRequest];
    
    while (!self.isOver && !self.cancelled) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}


//异步请求
- (void)loadRequest{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:1];
        if (self.cancelled) {
            return ;
        }
        NSLog(@"%@", self.operationName);
        self.isOver = YES;
    });
}
@end
