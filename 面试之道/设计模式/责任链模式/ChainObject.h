//
//  ChainObject.h
//  面试之道
//
//  Created by 龙格 on 2020/2/8.
//  Copyright © 2020 Paul Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ChainObject;

typedef void(^ResultBlock)(ChainObject *obj, BOOL handled);

@interface ChainObject : NSObject

@property (nonatomic, strong) ChainObject *nextResponder;

- (instancetype)initWithUrl:(NSString *)url;

// 责任链处理
- (void)handle:(ResultBlock)result;
- (void)print;

@end

