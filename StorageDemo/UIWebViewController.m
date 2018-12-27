//
//  UIWebViewController.m
//  StorageDemo
//
//  Created by zhanggui on 2018/12/27.
//  Copyright © 2018 zhanggui. All rights reserved.
//

#import "UIWebViewController.h"
#import "UIView+Toast.h"
@interface UIWebViewController ()<UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *contentWebView;

@end

@implementation UIWebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"storage_result" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self.contentWebView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:url];
}
#pragma mark - UITableViewDlegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.view makeToast:@"网页加载完成"];
    self.title = @"UIWebView加载";
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //    NSString *isSupport = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('is_support').text"];
    //    [self.view makeToast:isSupport];
    return YES;
}
#pragma mark - Lazy Load
- (UIWebView *)contentWebView {
    if (!_contentWebView) {
        _contentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        _contentWebView.layer.borderWidth = 1;
        _contentWebView.delegate = self;
        
        [self.view addSubview:_contentWebView];
    }
    return _contentWebView;
}


@end
