//
//  FileDB.h
//  面试之道
//
//  Created by 龙格 on 2019/11/21.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

// 将数据存储在文件中，为了和数据库事务操作做对比

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileDB : NSObject

+ (void)addNumbers:(NSArray *)numbers;

@end

NS_ASSUME_NONNULL_END
