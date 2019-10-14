//
//  CustomButton.m
//  面试之道
//
//  Created by 龙格 on 2019/2/18.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (!self.userInteractionEnabled && self.isHidden && self.alpha <= 0.01) {
        return nil;
    }
    
    if ([self pointInside:point withEvent:event]) {
        //如果点击区域是在当前的视图上面
        //遍历对象的子视图
        __block UIView *hit = nil;
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGPoint convertPoint = [self convertPoint:point toView:obj];
            hit = [obj hitTest:convertPoint withEvent:event];
            if (hit) {
                *stop = YES;
            }
        }];
        if (hit) {
            return hit;
        }else{
            return self;
        }
    }else{
        return nil;
    }
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGFloat x = point.x;
    CGFloat y = point.y;
    
    CGFloat x1 = self.frame.size.width / 2;
    CGFloat y1 = self.frame.size.height / 2;
    
    double dis = sqrt((x1-x)*(x1-x) + (y1-y)*(y1-y));
    
    if (dis <= self.frame.size.width / 2) {
        return YES;
    }else{
        return NO;
    }
}
@end
