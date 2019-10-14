//
//  Milk.h
//  面试之道
//
//  Created by 龙格 on 2019/2/12.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

/*
 装饰者模式：这是一个实现了CodimentDecorator协议的一个装饰者类
 */
#import <Foundation/Foundation.h>
#import "CodimentDecorator.h"
NS_ASSUME_NONNULL_BEGIN

@interface Milk : NSObject
@property (nonatomic, strong) id beverage;
- (instancetype)initWithBeverage:(id)beverage;
@end

NS_ASSUME_NONNULL_END
