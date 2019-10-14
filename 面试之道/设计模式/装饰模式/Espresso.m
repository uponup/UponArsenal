//
//  Espresso.m
//  面试之道
//
//  Created by 龙格 on 2019/2/12.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "Espresso.h"

@implementation Espresso{
    NSString *_name;
}

- (instancetype)init{
    if (self = [super init]) {
        _name = @"浓缩咖啡-Espresso";
    }
    return self;
}
- (NSString *)getName{
    return _name;
}
- (double)cost{
    return 12.0;
}
@end
