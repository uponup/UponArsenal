//
//  Son.m
//  面试之道
//
//  Created by 龙格 on 2019/10/15.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "Son.h"

@implementation Son

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
    }
    return self;
}

@end
