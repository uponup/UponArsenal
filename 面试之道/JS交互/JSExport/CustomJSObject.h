//
//  CustomJSObject.h
//  面试之道
//
//  Created by 龙格 on 2019/1/8.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

typedef void(^JSObjectBlock)(NSDictionary *dic);

@protocol CustomJSProtocol <JSExport>
- (void)jsCallMethod;
- (void)jsCallMethodWithParam:(NSString *)param;
- (void)jsCallMethodWithParam:(NSString *)param AndParamTwo:(NSString *)param2;

//暴露一个方法，来讲oc方法注入js中，可带参数
- (void)sendValueToHtml;
@end

@interface CustomJSObject: NSObject<CustomJSProtocol>
- (id)initWithSuccessCallback:(JSObjectBlock)success failCallback:(JSObjectBlock)fail;
@end
