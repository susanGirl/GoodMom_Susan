//
//  WebViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/31.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

@end

@implementation WebViewController
- (void)setWebViewUrl:(NSString *)webViewUrl{
    if (_webViewUrl != webViewUrl) {
        _webViewUrl = nil;
        _webViewUrl = webViewUrl;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:COLOR_arc green:COLOR_arc blue:COLOR_arc alpha:1.0];
    
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 30, kScreenW, kScreenH-70)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_webViewUrl]];
    
    [webView setDelegate:self];
    [self.view addSubview:webView];
    [webView loadRequest:request];
    
}
// 1.网页开始加载的时候调用
- (void )webViewDidStartLoad:(UIWebView *)webView{
    
    //创建UIActivityIndicatorView背底半透明View
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [activityIndicator setCenter:view.center];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:activityIndicator];
    
    
    [activityIndicator startAnimating];
    
    
}
// 2.网页加载完成的时候调用
- (void )webViewDidFinishLoad:(UIWebView *)webView{
    
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    
}
// 3.网页加载错误的时候调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
}

@end
