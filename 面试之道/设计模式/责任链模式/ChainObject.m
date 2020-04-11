//
//  ChainObject.m
//  面试之道
//
//  Created by 龙格 on 2020/2/8.
//  Copyright © 2020 Paul Gao. All rights reserved.
//

#import "ChainObject.h"
typedef void(^HandledCompletion)(BOOL handled);

@interface ChainObject () {
    NSString *_url;
}
@end

@implementation ChainObject

- (instancetype)initWithUrl:(NSString *)url {
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

- (void)handle:(ResultBlock)result {
    HandledCompletion completion = ^(BOOL handled){
        if (handled) {
            result(self, YES);
        }else {
            if (self.nextResponder) {
                [self.nextResponder handle:result];
            }else {
                result(nil, NO);
            }
        }
    };
    [self handleChainObject:completion];
}

- (void)handleChainObject:(HandledCompletion)completion {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:1];
        if (self.nextResponder) {
            completion(NO);
        }else {
            completion(YES);
        }
    });
}

- (void)print {
    NSLog(@"====: %@", _url);
}

@end
