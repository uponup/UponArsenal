//
//  MallardDuck.m
//  面试之道
//
//  Created by 龙格 on 2019/2/12.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "MallardDuck.h"
#import "FlyWithWings.h"
#import "GaGaQuack.h"
@implementation MallardDuck
- (instancetype)init{
    if (self = [super init]) {
        self.flyBehavior = [[FlyWithWings alloc] init];
        self.quackBehavior = [[GaGaQuack alloc] init];
    }
    return self;
}
@end
