//
//  JPWebController.m
//  面试之道
//
//  Created by 龙格 on 2019/1/8.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "JPWebController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "CustomJSObject.h"


@interface JPWebController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *leftButton;
@end

@implementation JPWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.rightButton.frame = CGRectMake(0, 0, 100, 34);
    [self.rightButton setTitle:@"调用html方法" forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = item;
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.leftButton.frame = CGRectMake(0, 0, 100, 34);
    [self.leftButton setTitle:@"按钮" forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
     [self.leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnAction:(UIButton *)btn{
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    CustomJSObject *object = [CustomJSObject new];
    NSString *textJS = [NSString stringWithFormat:@"methodForOC()"];
    [context evaluateScript:textJS];
    context[@"native"] = object;
}
- (void)leftAction:(UIButton *)btn{
    NSLog(@"点击左边按钮");
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self addCustomAction];
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self.rightButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)addCustomAction{
    //JSContext:js执行环境，包含了js执行的函数和对象
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    CustomJSObject *object = [[CustomJSObject alloc] initWithSuccessCallback:^(NSDictionary *dic) {
        if ([[dic.allKeys firstObject] isEqualToString:@"jsCallMethod"]) {
            NSLog(@">>>js调用成功：无参数的方法");
        }else if ([[dic.allKeys firstObject] isEqualToString:@"jsCallMethodWithParam"]){
            NSLog(@">>>js调用成功：一个参数的方法：%@", dic);
        }else if ([[dic.allKeys firstObject] isEqualToString:@"jsCallMethodWithTwoParam"]){
            NSLog(@">>>js调用成功：两个参数的方法：%@", dic);
        }else if ([[dic.allKeys firstObject] isEqualToString:@"OcCallJS"]){
            NSString *name = @"高晋鹏";
            NSString *age = @"19";
            NSString *textJS = [NSString stringWithFormat:@"getUsernameAndAge('%@', '%@')", name, age];
            [context evaluateScript:textJS];
        }
    } failCallback:^(NSDictionary *dic) {
        NSLog(@"error: %@", dic);
    }];
    context[@"pxzline"] = object;
}


#pragma mark - Private Method
- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://lesson.pxzline.com/pxzschool/godbookh5app.html?user_id=&mold=10"]]];
//        NSString *path = [[NSBundle mainBundle] bundlePath];
//        NSURL *basePath = [NSURL fileURLWithPath:path];
//        NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"html"];
//        NSString *htmlContent = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
//        [_webView loadHTMLString:htmlContent baseURL:basePath];
    }
    return _webView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
