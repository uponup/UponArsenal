//
//  TransactionDB.m
//  面试之道
//
//  Created by 龙格 on 2019/11/21.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "TransactionDB.h"
#import "FMDB.h"

@implementation TransactionDB

+ (void)load {
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithURL:[self path]];
    if (queue) {
        [queue inDatabase:^(FMDatabase * _Nonnull db) {
            BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS logs (number text PRIMARY KEY, label text)"];
            if (result) {
                NSLog(@"load table t_localCallLogs success...");
            } else {
                NSLog(@"load table t_localCallLogs fail...");
            }
        }];
    }
}


+ (void)addNumbers:(NSArray *)numbers {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithURL:[self path]];
    [queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        for (int i = 0; i < numbers.count; i++) {
            [db executeUpdate:@"insert into logs (number, label) values(?, ?)", numbers[i], @(i)];
        }
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

+ (NSArray *)allNumbers {
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithURL:[self path]];
    __block NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:0];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    [queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        FMResultSet *set = [db executeQuery:@"select *from logs"];
        while ([set next]) {
            NSString *number = [set stringForColumn:@"number"];
            [dataArr addObject:number];
        }
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return dataArr;
}

+ (NSString *)getLastNumber {
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithURL:[self path]];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block NSString *phoneNumber = nil;
    [queue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *set = [db executeQuery:@"select * from logs order by phoneNumber desc limit 1"];
        while ([set next]) {
            phoneNumber = [set stringForColumn:@"phoneNumber"];
        }
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    return phoneNumber;
}

#pragma mark - Private Mehtod
+ (NSURL *)path {
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:Identifier_AppGroup];
    containerURL = [containerURL URLByAppendingPathComponent:@"db.sqlite"];
    
    NSLog(@"===>:%@", containerURL);
    return containerURL;
}
@end
