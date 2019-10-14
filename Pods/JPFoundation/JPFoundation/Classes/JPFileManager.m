//
//  JPFileManager.m
//  Test
//
//  Created by 龙格 on 2019/10/11.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "JPFileManager.h"

@implementation JPFileManager

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"PodsNotificationTest" object:nil];
    }
    return self;
}

- (void)notificationAction:(NSNotification *)noti {
    NSLog(@"哈哈哈哈哈哈, 收到了通知");
}

@end
