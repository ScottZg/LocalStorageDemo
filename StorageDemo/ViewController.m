//
//  ViewController.m
//  StorageDemo
//
//  Created by zhanggui on 16/7/29.
//  Copyright © 2016年 zhanggui. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Toast.h"
#import "UIWebViewController.h"
#import "WKWebViewController.h"
@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *contentWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"storage" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self.contentWebView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:url];
}
- (IBAction)openNewVC:(id)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择" message:@"请选择h要打开新页面的容器，该页面会通过localStorage展示当前页面的访问次数" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *uiAction = [UIAlertAction actionWithTitle:@"UIWebViewController" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIWebViewController *vc = [[UIWebViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction *wkAction = [UIAlertAction actionWithTitle:@"UIWebViewController" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        WKWebViewController *vc = [[WKWebViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:cancelAction];
    [alertVC addAction:uiAction];
    [alertVC addAction:wkAction];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}
- (IBAction)clearLocalStorageAction:(id)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选项" message:@"请选择相应的操作进行点击" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *uiAction = [UIAlertAction actionWithTitle:@"清空localstorage" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.contentWebView stringByEvaluatingJavaScriptFromString:@"localStorage.clear()"];
        
        [self.contentWebView reload];

    }];
    UIAlertAction *wkAction = [UIAlertAction actionWithTitle:@"网页重新加载" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       [self.contentWebView reload];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:cancelAction];
    [alertVC addAction:uiAction];
    [alertVC addAction:wkAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
#pragma mark - UITableViewDlegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.view makeToast:@"网页加载完成"];
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
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
