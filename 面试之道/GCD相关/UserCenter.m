//
//  UserCenter.m
//  面试之道
//
//  Created by 龙格 on 2020/2/4.
//  Copyright © 2020 Paul Gao. All rights reserved.
//

#import "UserCenter.h"

@interface UserCenter (){
    dispatch_queue_t current_Queue;
    NSMutableDictionary *dic;
}

@end
@implementation UserCenter

- (instancetype)init {
    self = [super init];
    if (self) {
        current_Queue = dispatch_queue_create("read_write_queue", DISPATCH_QUEUE_CONCURRENT);
        dic = [NSMutableDictionary dictionary];
    }
    return self;
}

- (id)objectForKey:(NSString *)key {
    __block id obj;
    dispatch_sync(current_Queue, ^{
        obj = [dic objectForKey:key];
    });
    return obj;
}

- (void)setObject:(id)obj forKey:(NSString *)key {
    // 使用async，优先立刻写入数据
    dispatch_barrier_async(current_Queue, ^{
        [dic setObject:obj forKey:key];
    });
}


@end
