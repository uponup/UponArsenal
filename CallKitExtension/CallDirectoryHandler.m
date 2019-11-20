//
//  CallDirectoryHandler.m
//  CallKitExtension
//
//  Created by 龙格 on 2019/11/20.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "CallDirectoryHandler.h"

@interface CallDirectoryHandler () <CXCallDirectoryExtensionContextDelegate>
@end

@implementation CallDirectoryHandler

- (void)beginRequestWithExtensionContext:(CXCallDirectoryExtensionContext *)context {
    context.delegate = self;

//    if (![self addIdentificationPhoneNumbersToContext:context]) {
//        NSError *error = [NSError errorWithDomain:@"CallDirectoryHandler" code:2 userInfo:nil];
//        [context cancelRequestWithError:error];
//        return;
//    }
    
    // 来电识别
    [context removeAllIdentificationEntries];
    // block
    [context removeAllBlockingEntries];
    
    [context completeRequestWithCompletionHandler:nil];
}

- (BOOL)addIdentificationPhoneNumbersToContext:(CXCallDirectoryExtensionContext *)context {
    // 利用APP Group把待写入系统数据写到共享区域
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:Identifier_AppGroup];
    containerURL = [containerURL URLByAppendingPathComponent:FileName_AppGroup];
    
    FILE *file = fopen([containerURL.path UTF8String], "r");
    if (!file) {
        return YES;
    }
    char buffer[1024];
    
    // 一行一行的读，避免爆内存
    while (fgets(buffer, 1024, file) != NULL) {
        @autoreleasepool {
            NSString *result = [NSString stringWithUTF8String:buffer];
            NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingAllowFragments
                                                                  error:&err];
            
            if(!err && dic && [dic isKindOfClass:[NSDictionary class]]) {
                NSString *number = dic.allKeys[0];
                NSString *name = dic[number];
                if (number && [number isKindOfClass:[NSString class]] &&
                    name && [name isKindOfClass:[NSString class]]) {
                    CXCallDirectoryPhoneNumber phoneNumber = [number longLongValue];
                   
                }
            }
            
            dic = nil;
            result = nil;
            jsonData = nil;
            err = nil;
        }
    }
    fclose(file);
    
    return YES;
}





- (void)addAllBlockingPhoneNumbersToContext:(CXCallDirectoryExtensionContext *)context {
    // Retrieve phone numbers to block from data store. For optimal performance and memory usage when there are many phone numbers,
    // consider only loading a subset of numbers at a given time and using autorelease pool(s) to release objects allocated during each batch of numbers which are loaded.
    //
    // Numbers must be provided in numerically ascending order.
    CXCallDirectoryPhoneNumber allPhoneNumbers[] = { 14085555555, 18005555555 };
    NSUInteger count = (sizeof(allPhoneNumbers) / sizeof(CXCallDirectoryPhoneNumber));
    for (NSUInteger index = 0; index < count; index += 1) {
        CXCallDirectoryPhoneNumber phoneNumber = allPhoneNumbers[index];
        [context addBlockingEntryWithNextSequentialPhoneNumber:phoneNumber];
    }
}

- (void)addOrRemoveIncrementalBlockingPhoneNumbersToContext:(CXCallDirectoryExtensionContext *)context {
    // Retrieve any changes to the set of phone numbers to block from data store. For optimal performance and memory usage when there are many phone numbers,
    // consider only loading a subset of numbers at a given time and using autorelease pool(s) to release objects allocated during each batch of numbers which are loaded.
    CXCallDirectoryPhoneNumber phoneNumbersToAdd[] = { 14085551234 };
    NSUInteger countOfPhoneNumbersToAdd = (sizeof(phoneNumbersToAdd) / sizeof(CXCallDirectoryPhoneNumber));

    for (NSUInteger index = 0; index < countOfPhoneNumbersToAdd; index += 1) {
        CXCallDirectoryPhoneNumber phoneNumber = phoneNumbersToAdd[index];
        [context addBlockingEntryWithNextSequentialPhoneNumber:phoneNumber];
    }

    CXCallDirectoryPhoneNumber phoneNumbersToRemove[] = { 18005555555 };
    NSUInteger countOfPhoneNumbersToRemove = (sizeof(phoneNumbersToRemove) / sizeof(CXCallDirectoryPhoneNumber));
    for (NSUInteger index = 0; index < countOfPhoneNumbersToRemove; index += 1) {
        CXCallDirectoryPhoneNumber phoneNumber = phoneNumbersToRemove[index];
        [context removeBlockingEntryWithPhoneNumber:phoneNumber];
    }

    // Record the most-recently loaded set of blocking entries in data store for the next incremental load...
}

- (void)addAllIdentificationPhoneNumbersToContext:(CXCallDirectoryExtensionContext *)context {
    // Retrieve phone numbers to identify and their identification labels from data store. For optimal performance and memory usage when there are many phone numbers,
    // consider only loading a subset of numbers at a given time and using autorelease pool(s) to release objects allocated during each batch of numbers which are loaded.
    //
    // Numbers must be provided in numerically ascending order.
    CXCallDirectoryPhoneNumber allPhoneNumbers[] = { 18775555555, 18885555555 };
    NSArray<NSString *> *labels = @[ @"Telemarketer", @"Local business" ];
    NSUInteger count = (sizeof(allPhoneNumbers) / sizeof(CXCallDirectoryPhoneNumber));
    for (NSUInteger i = 0; i < count; i += 1) {
        CXCallDirectoryPhoneNumber phoneNumber = allPhoneNumbers[i];
        NSString *label = labels[i];
        [context addIdentificationEntryWithNextSequentialPhoneNumber:phoneNumber label:label];
    }
}

- (void)addOrRemoveIncrementalIdentificationPhoneNumbersToContext:(CXCallDirectoryExtensionContext *)context {
    // Retrieve any changes to the set of phone numbers to identify (and their identification labels) from data store. For optimal performance and memory usage when there are many phone numbers,
    // consider only loading a subset of numbers at a given time and using autorelease pool(s) to release objects allocated during each batch of numbers which are loaded.
    CXCallDirectoryPhoneNumber phoneNumbersToAdd[] = { 14085555678 };
    NSArray<NSString *> *labelsToAdd = @[ @"New local business" ];
    NSUInteger countOfPhoneNumbersToAdd = (sizeof(phoneNumbersToAdd) / sizeof(CXCallDirectoryPhoneNumber));

    for (NSUInteger i = 0; i < countOfPhoneNumbersToAdd; i += 1) {
        CXCallDirectoryPhoneNumber phoneNumber = phoneNumbersToAdd[i];
        NSString *label = labelsToAdd[i];
        [context addIdentificationEntryWithNextSequentialPhoneNumber:phoneNumber label:label];
    }

    CXCallDirectoryPhoneNumber phoneNumbersToRemove[] = { 18885555555 };
    NSUInteger countOfPhoneNumbersToRemove = (sizeof(phoneNumbersToRemove) / sizeof(CXCallDirectoryPhoneNumber));

    for (NSUInteger i = 0; i < countOfPhoneNumbersToRemove; i += 1) {
        CXCallDirectoryPhoneNumber phoneNumber = phoneNumbersToRemove[i];
        [context removeIdentificationEntryWithPhoneNumber:phoneNumber];
    }

    // Record the most-recently loaded set of identification entries in data store for the next incremental load...
}

#pragma mark - CXCallDirectoryExtensionContextDelegate

- (void)requestFailedForExtensionContext:(CXCallDirectoryExtensionContext *)extensionContext withError:(NSError *)error {
    // An error occurred while adding blocking or identification entries, check the NSError for details.
    // For Call Directory error codes, see the CXErrorCodeCallDirectoryManagerError enum in <CallKit/CXError.h>.
    //
    // This may be used to store the error details in a location accessible by the extension's containing app, so that the
    // app may be notified about errors which occured while loading data even if the request to load data was initiated by
    // the user in Settings instead of via the app itself.
}

@end