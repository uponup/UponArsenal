//
//  ViewReusePool.h
//  面试之道
//
//  Created by 龙格 on 2019/2/2.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ViewReusePool : NSObject
- (UIView *)dequeueReusableView;
- (void)addReusePool:(UIView *)view;
- (void)reset;
@end

NS_ASSUME_NONNULL_END
