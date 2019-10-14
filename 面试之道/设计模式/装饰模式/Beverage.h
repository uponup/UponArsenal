//
//  Beverage.h
//  面试之道
//
//  Created by 龙格 on 2019/2/12.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Beverage <NSObject>
@optional
- (NSString *)getName;
- (double)cost;
@end

NS_ASSUME_NONNULL_END
