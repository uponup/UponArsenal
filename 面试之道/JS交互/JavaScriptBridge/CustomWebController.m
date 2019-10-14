//
//  CustomWebController.m
//  面试之道
//
//  Created by 龙格 on 2019/1/11.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "CustomWebController.h"
#import <WebViewJavascriptBridge.h>
@interface CustomWebController ()
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@end

@implementation CustomWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    
    //js调用oc的方法，先注册该方法
    [self.bridge registerHandler:@"changeColor" handler:^(id data, WVJBResponseCallback responseCallback) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0];
        responseCallback(@"颜色修改完毕");
    }];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightButton setTitle:@"改变背景颜色" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)rightItemClick:(UIButton *)btn{
    //oc调用js的方法
    [self.bridge callHandler:@"changeBGColor" data:@"把HTML背景颜色改成橙色！" responseCallback:^(id responseData) {
        NSLog(@"%@", responseData);
    }];
}


#pragma mark - Lazy Method
- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [self.view addSubview:_webView];
        
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *basePath = [NSURL fileURLWithPath:path];
        NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"demo3" ofType:@"html"];
        NSString *htmlContent = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
        [_webView loadHTMLString:htmlContent baseURL:basePath];
    }
    return _webView;
}
@end
