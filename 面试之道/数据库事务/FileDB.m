//
//  FileDB.m
//  面试之道
//
//  Created by 龙格 on 2019/11/21.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "FileDB.h"

@implementation FileDB

+ (void)addNumbers:(NSArray *)numbers {
    
}

+ (NSURL *)path {
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:Identifier_AppGroup];
    containerURL = [containerURL URLByAppendingPathComponent:@"numbers.file"];
    NSLog(@"===>:%@", containerURL);
    return containerURL;
}

@end
