//
//  WKWebViewController.m
//  StorageDemo
//
//  Created by zhanggui on 2018/12/27.
//  Copyright © 2018 zhanggui. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "UIView+Toast.h"
@interface WKWebViewController ()<WKUIDelegate,WKNavigationDelegate>


@property (nonatomic,strong)WKWebView *contentWebView;
@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentWebView];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"storage_result" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
//    NSData *data = [NSData dataWithContentsOfURL:url];

    [self.contentWebView loadRequest:[NSURLRequest requestWithURL:url]];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.view makeToast:@"网页加载完成"];
    self.title = @"WKWebView加载";

}
#pragma mark - lazy load
- (WKWebView *)contentWebView {
    if (!_contentWebView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        _contentWebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:config];
        _contentWebView.UIDelegate = self;
        _contentWebView.navigationDelegate = self;
    }
    return _contentWebView;
}

@end