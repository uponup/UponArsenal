//
//  TransactionDB.h
//  面试之道
//
//  Created by 龙格 on 2019/11/21.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransactionDB : NSObject

+ (void)addNumbers:(NSArray *)numbers;
+ (NSArray *)allNumbers;
+ (NSString *)getLastNumber;

@end

NS_ASSUME_NONNULL_END
