//
//  RuntimeController.m
//  面试之道
//
//  Created by 龙格 on 2019/10/15.
//  Copyright © 2019 Paul Gao. All rights reserved.
//

#import "RuntimeController.h"
#import "Son.h"
#import <objc/runtime.h>

#import "GeoObject.h"

@interface RuntimeController ()
@property (nonatomic, strong) GeoObject *obj;

@end

@implementation RuntimeController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self demo001];
//    [self demo002];
    
    // 反地理编码
    [self geoObjectMethod];
}

- (void)geoObjectMethod {
    self.obj = [[GeoObject alloc] init];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (NSInteger i=0; i<1; i++) {
            [NSThread sleepForTimeInterval:1];
            [self.obj currentGeocoder];
            [self.obj reverseGeocoder];
        }
    });
}



#pragma mark - 1、消息转发
- (void)demo001 {
    [self performSelector:@selector(info)];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(info)) {
//        class_addMethod([self class], sel, (IMP)methodInfo, "v@:");
        return [super resolveInstanceMethod:sel];
    }
    return YES;
}

void methodInfo(id obj, SEL _cmd) {
    NSLog(@"Method info invoke!");
}

// 备用方法接收者
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(info)) {
        // 转发到Person对象
        return [Person new];
    }
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    /*
     * 如果forwardingTargetForSelector返回nil，找不到备用的消息接收者，那么就会调用此方法
     * 这是完成的消息转发，然后在forwardInvocation中获取函数和返回值类型
     * methodSignatureForSelector获取函数和返回值类型
     */
    if ([NSStringFromSelector(aSelector) isEqualToString:@"info"]) {
        return [NSMethodSignature methodSignatureForSelector:aSelector];
    }
    return [super methodSignatureForSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL sel = anInvocation.selector;
    Person *p = [Person new];
    if ([p respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:p];
    }else{
        [self doesNotRecognizeSelector:sel];
    }
}

#pragma mark - 2、self和super
- (void)demo002 {
    Son *son = [Son new];
    
}


@end
