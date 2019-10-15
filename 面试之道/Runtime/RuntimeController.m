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

@interface RuntimeController ()

@end

@implementation RuntimeController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self demo001];
    [self demo002];
}

#pragma mark - 1、消息转发
- (void)demo001 {
    [self performSelector:@selector(info)];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(info)) {
        class_addMethod([self class], sel, (IMP)methodInfo, "v@:");
        return [super resolveInstanceMethod:sel];
    }
    return NO;
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
