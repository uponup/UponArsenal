//
//  CallDirectoryManager.h
//  面试之道
//
//  Created by 龙格 on 2019/11/20.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CallKit/CallKit.h>

typedef NS_ENUM(NSInteger, CallDirectoryAuth) {
    CallDirectoryAuth_enable = 1,
    CallDirectoryAuth_disable,
    CallDirectoryAuth_error
};

NS_ASSUME_NONNULL_BEGIN

@interface CallDirectoryManager : NSObject

+ (instancetype)sharedInstance;

- (CallDirectoryAuth)requestAuth;
- (void)addPhoneNumber:(NSString *)phoneNumber withLabel:(NSString *)label;
- (BOOL)reloadExtensionContext;

- (void)removeAll;
@end

NS_ASSUME_NONNULL_END
