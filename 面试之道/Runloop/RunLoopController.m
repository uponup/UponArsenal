//
//  RunLoopController.m
//  面试之道
//
//  Created by 龙格 on 2019/1/16.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "RunLoopController.h"

@interface RunLoopController ()
@property (nonatomic, strong) IBOutlet UITextView *textView;
@end

@implementation RunLoopController


/**
 RunLoop: 时钟事件、触摸事件
 模式有以下三个组成：Observer，Timer，Source
 Source: 事件源。按照函数调用栈，分成Source0，和Source1（系统事件源）
 */
- (void)viewDidLoad {
    [super viewDidLoad];

//    [self demo1];
//    [self demo2];
//    [self gcdTimer];
    
//    [self commonModeDemo];
//    [self threadTimer];
//    [self gcdTimer];
    [self gcdTimer2];
}

- (void)gcdTimer2{
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"%@", [NSThread currentThread]);
    });
    
    dispatch_resume(timer);
}

//子线程开启timer
- (void)threadTimer{
    NSLog(@"这是主线程");
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] run];
    }];
    [thread start];
}

- (void)commonModeDemo{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)gcdTimer{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"gcd的timer事件");
    });
    dispatch_resume(timer);
}

- (void)demo1{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}
- (void)demo2{
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}
- (void)timerAction{
    NSLog(@"来了");
}
@end
