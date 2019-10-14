//
//  Duck.m
//  面试之道
//
//  Created by 龙格 on 2019/2/12.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "Duck.h"

@implementation Duck

- (void)fly{
    [self.flyBehavior fly];
}

- (void)quack{
    [self.quackBehavior quack];
}
@end
