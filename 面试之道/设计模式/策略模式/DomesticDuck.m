//
//  DomesticDuck.m
//  面试之道
//
//  Created by 龙格 on 2019/2/12.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//
　
#import "DomesticDuck.h"
#import "FlyNoWay.h"
#import "GuGuQuack.h"
@implementation DomesticDuck
- (instancetype)init{
    if (self = [super init]) {
        self.flyBehavior = [[FlyNoWay alloc] init];
        self.quackBehavior = [[GuGuQuack alloc] init];
    }
    return self;
}
@end
