//
//  GeoObject.h
//  面试之道
//
//  Created by 龙格 on 2020/2/5.
//  Copyright © 2020 Paul Gao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GeoObject : NSObject

- (void)currentGeocoder;
- (void)reverseGeocoder;

@end

NS_ASSUME_NONNULL_END
