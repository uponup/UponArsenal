//
//  Mocha.m
//  面试之道
//
//  Created by 龙格 on 2019/2/12.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "Mocha.h"

@implementation Mocha{
    NSString *_name;
}

- (instancetype)initWithBeverage:(id)beverage{
    if (self = [super init]) {
        _name = @"加了摩卡";
        self.beverage = beverage;
    }
    return self;
}
- (NSString *)getName{
    return [NSString stringWithFormat:@"%@ - %@", _name, [self.beverage getName]];
}
- (double)cost{
    return 4.2 + [self.beverage cost];
}
@end
