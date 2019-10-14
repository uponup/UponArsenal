//
//  WkWebViewController.m
//  面试之道
//
//  Created by 龙格 on 2019/1/10.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "WkWebViewController.h"
#import <WebKit/WebKit.h>

@interface WkWebViewController ()<WKScriptMessageHandler, WKUIDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIButton *rightButton;
@end

@implementation WkWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //js调用oc----注册js方法
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"jsFunc"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"jsFuncTwo"];
    [self.webView setUIDelegate:self];
    [self loadHtmlContent];
}
- (void)loadHtmlContent{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *basePath = [NSURL fileURLWithPath:path];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"demo2" ofType:@"html"];
    NSString *htmlContent = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlContent baseURL:basePath];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.rightButton setTitle:@"OC调用JS" forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)rightButtonAction:(UIButton *)btn{
    //oc调用js，WKWebView对警告框，确认面板，输入框并不能直接响应，是通过三个代理方法来实现的
    [self.webView evaluateJavaScript:@"alertAction('OC调用JS警告窗方法')" completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        NSLog(@"%@, %@", item, error);
    }];
}
#pragma mark - WKUIDelegate
//警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    [self alertWithTitle:@"oc调用js" content:message];
    completionHandler();
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    completionHandler(YES);
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    completionHandler(@"空");
}
#pragma mark - WKScriptMessageHandler
//这是oc对js中方法的响应
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSString *mesg = [NSString stringWithFormat:@"\n方法名：%@,\n参数：%@",message.name, message.body];
    if ([message.name isEqualToString:@"jsFunc"]) {
         [self alertWithTitle:@"js调用oc" content:mesg];
    }else if ([message.name isEqualToString:@"jsFuncTwo"]) {
        [self alertWithTitle:@"js调用oc" content:mesg];
    }
}

#pragma mark - Private Method
- (void)alertWithTitle:(NSString *)title content:(NSString *)content{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - Lazy Method
- (WKWebView *)webView{
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userContent = [[WKUserContentController alloc] init];
        config.userContentController = userContent;
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) configuration:config];
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
