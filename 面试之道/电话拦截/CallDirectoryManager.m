//
//  CallDirectoryManager.m
//  面试之道
//
//  Created by 龙格 on 2019/11/20.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "CallDirectoryManager.h"

@interface CallDirectoryManager ()
@property (nonatomic, strong) NSMutableDictionary *dataList;
@end

@implementation CallDirectoryManager

+ (instancetype)sharedInstance {
    static CallDirectoryManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[CallDirectoryManager alloc] init];
    });
    return _manager;
}

- (CallDirectoryAuth)requestAuth {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    CXCallDirectoryManager *manager = [CXCallDirectoryManager sharedInstance];
    __block CallDirectoryAuth authType = CallDirectoryAuth_error;
    [manager getEnabledStatusForExtensionWithIdentifier:Identifier_AppExtension completionHandler:^(CXCallDirectoryEnabledStatus enabledStatus, NSError * _Nullable error) {
        if (enabledStatus == CXCallDirectoryEnabledStatusEnabled) {
            authType = CallDirectoryAuth_enable;
        }else if (enabledStatus == CXCallDirectoryEnabledStatusDisabled) {
            authType = CallDirectoryAuth_disable;
            NSLog(@"获取权限失败：%@", error.localizedDescription);
        }else {
            NSLog(@"获取权限失败：%@", error.localizedDescription);
        }
        
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return authType;
}

- (void)addPhoneNumber:(NSString *)phoneNumber withLabel:(NSString *)label {
    if (phoneNumber.length == 0) return;
    
    if ([self.dataList objectForKey:phoneNumber]) return;
    
    [self.dataList setObject:label forKey:phoneNumber];
}

- (BOOL)reloadExtensionContext {
    if (self.dataList.count==0) return NO;
    if (![self writeDataToAppGroupFile]) return NO;
    
    __block BOOL reloadSuccess = YES;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    CXCallDirectoryManager *manager = [CXCallDirectoryManager sharedInstance];
    [manager reloadExtensionWithIdentifier:Identifier_AppExtension completionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"reload失败：%@", error.localizedDescription);
        }
        reloadSuccess = !error;
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return reloadSuccess;
}

#pragma mark - Private Method
- (BOOL)writeDataToAppGroupFile {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *containerURL = [fileManager containerURLForSecurityApplicationGroupIdentifier:Identifier_AppGroup];
    containerURL = [containerURL URLByAppendingPathComponent:FileName_AppGroup];
    NSString* filePath = containerURL.path;
    
    if (!filePath || ![filePath isKindOfClass:[NSString class]]) {
        return NO;
    }
    
    if([fileManager fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath error:nil];
    }
    
    if (![fileManager createFileAtPath:filePath contents:nil attributes:nil]) {
        return NO;
    }
    
    BOOL result = [[self dataToString] writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [self clearPhoneNumber];
    
    return result;
}

- (NSString *)dataToString {
    NSMutableArray *phoneArray = [NSMutableArray arrayWithArray:[self.dataList allKeys]];
    [phoneArray sortUsingSelector:@selector(compare:)];
    NSMutableString *dataStr = [[NSMutableString alloc] init];
    
    for (NSString *phone in phoneArray) {
        NSString *label = self.dataList[phone];
        NSString *dicStr = [NSString stringWithFormat:@"{\"%@\":\"%@\"}\n", phone, label];
        [dataStr appendString:dicStr];
    }
    
    return [dataStr copy];
}

- (void)clearPhoneNumber {
    [self.dataList removeAllObjects];
}

- (void)removeAll {
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:Identifier_AppGroup];
    [userDefaults setBool:YES forKey:@"RemoveAll"];
    [userDefaults synchronize];
    
    [self.dataList removeAllObjects];
    CXCallDirectoryManager *manager = [CXCallDirectoryManager sharedInstance];
    [manager reloadExtensionWithIdentifier:Identifier_AppExtension completionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"删除reload失败：%@", error.localizedDescription);
        }else {
            NSLog(@"删除reload成功");

        }
    }];
}

#pragma mark - Lazy Method

- (NSMutableDictionary *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableDictionary dictionaryWithCapacity:0];

        // 将全部号码加载到缓存中
        NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:Identifier_AppGroup];
        containerURL = [containerURL URLByAppendingPathComponent:FileName_AppGroup];
        
        FILE *file = fopen([containerURL.path UTF8String], "r");
        if (file) {
            char buffer[1024];
            
            // 一行一行的读，避免爆内存
            while (fgets(buffer, 1024, file) != NULL) {
                @autoreleasepool {
                    NSString *result = [NSString stringWithUTF8String:buffer];
                    NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
                    NSError *err;
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
                    
                    if(!err && dic && [dic isKindOfClass:[NSDictionary class]]) {
                        NSString *number = dic.allKeys[0];
                        NSString *name = dic[number];
                        if (number && [number isKindOfClass:[NSString class]] &&
                            name && [name isKindOfClass:[NSString class]]) {
                            [_dataList setObject:name forKey:number];
                        }
                    }
                    
                    dic = nil;
                    result = nil;
                    jsonData = nil;
                    err = nil;
                }
            }
            fclose(file);
        }
    }
    return _dataList;
}

@end
