//
//  Duck.h
//  面试之道
//
//  Created by 龙格 on 2019/2/12.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Duck : NSObject
@property (nonatomic, strong) id flyBehavior;
@property (nonatomic, strong) id quackBehavior;

- (void)fly;
- (void)quack;
@end

NS_ASSUME_NONNULL_END
