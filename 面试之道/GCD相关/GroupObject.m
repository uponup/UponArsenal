//
//  GroupObject.m
//  面试之道
//
//  Created by 龙格 on 2020/2/4.
//  Copyright © 2020 Paul Gao. All rights reserved.
//

#import "GroupObject.h"

@interface GroupObject (){
    dispatch_queue_t downloadQueue;
    NSMutableArray *urls;
}

#define Arr @[@"任务1", @"任务2", @"任务3"]
@end
@implementation GroupObject

- (instancetype)init {
    self = [super init];
    if (self) {
        downloadQueue = dispatch_queue_create("download_concurrent_queue", DISPATCH_QUEUE_CONCURRENT);
        urls = [NSMutableArray arrayWithArray:Arr];
    }
    return self;
}

- (void)handle {
    dispatch_group_t group = dispatch_group_create();
    
    for (NSString *url in urls) {
        dispatch_group_async(group, downloadQueue, ^{
            NSLog(@"%@", url);
        });
    }
    
    dispatch_group_notify(group, downloadQueue, ^{
        NSLog(@"任务结束");
    });
}


// 拓展：
// dispatch_group_enter
// dispatch_group_leave
// dispatch_group_wait
// dispatch_group_notify

@end
