//
//  TicketManager.m
//  面试之道
//
//  Created by 龙格 on 2019/1/31.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "TicketManager.h"

#define Total 50
@interface TicketManager ()
@property int ticketsCount; //剩余票数
@property int saleCount;    //卖出票数
@property (nonatomic, strong) NSThread *threadBJ;
@property (nonatomic, strong) NSThread *threadSH;

@property (nonatomic, strong) NSCondition *condition;
@property (nonatomic, strong) NSLock *lock;
@end
@implementation TicketManager

- (instancetype)init{
    self = [super init];
    if (self) {
        self.condition = [[NSCondition alloc] init];
        self.lock = [[NSLock alloc] init];
        self.ticketsCount = Total;
        self.threadBJ = [[NSThread alloc] initWithTarget:self selector:@selector(sale) object:nil];
        [self.threadBJ setName:@"北京票务中心"];
        
        self.threadSH = [[NSThread alloc] initWithTarget:self selector:@selector(sale) object:nil];
        [self.threadSH setName:@"上海票务中心"];
    }
    return self;
}
- (void)sale{
    while (true) {
//        @synchronized (self) {
//        [self.condition lock];
        [self.lock lock];
            if (self.ticketsCount > 0) {
                self.ticketsCount--;
                self.saleCount = Total - self.ticketsCount;
                [NSThread sleepForTimeInterval:1];
                NSLog(@"已经卖了%d张票，剩余%d张",self.saleCount, self.ticketsCount);
            }else{
                break;
            }
//        [self.condition unlock];
        [self.lock unlock];
//        }
    }
}

- (void)startSale{
    [self.threadSH start];
    [self.threadBJ start];
}
@end
