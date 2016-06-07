//
//  WebViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/31.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "WebViewController.h"
#import "MBProgressHUD+gifHUD.h"
@interface WebViewController ()<UIWebViewDelegate>
@property(assign,nonatomic)BOOL  flag;
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
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-70)];
    _webView.scalesPageToFit = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_webViewUrl]];
    
    [_webView setDelegate:self];
    [self.view addSubview:_webView];
    [_webView loadRequest:request];
    
    
    
    self.navigationItem.hidesBackButton = YES;

    self.title = _name;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"清新导航条.png"] forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回首页" style:(UIBarButtonItemStylePlain) target:self action:@selector(backHomeAction)];
//    backItem.tintColor = [UIColor orangeColor];
    
    self.navigationItem.rightBarButtonItem = backItem;
}
- (void)backHomeAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"好妈妈导航条.png"] forBarMetrics:UIBarMetricsDefault];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    if (_flag == NO) {
        [MBProgressHUD setupHUDWithFrame:CGRectMake(0, 0, 50, 50) gifName:@"pika" andShowToView:self.view];
        _flag = YES;
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    if (_flag == YES) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        _flag = NO;
    }
}
@end
