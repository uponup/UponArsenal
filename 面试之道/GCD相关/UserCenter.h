//
//  UserCenter.h
//  面试之道
//
//  Created by 龙格 on 2020/2/4.
//  Copyright © 2020 Paul Gao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserCenter : NSObject

- (id)objectForKey:(NSString *)key;
- (void)setObject:(id)obj forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
