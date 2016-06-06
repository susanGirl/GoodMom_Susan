//
//  WebsViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/6.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "WebsViewController.h"
#import "KnowTitleModel.h"
@interface WebsViewController ()<UIWebViewDelegate>
@property (strong,nonatomic)UIWebView *webView;
@end

@implementation WebsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-70)];
    
    _webView.scalesPageToFit = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_model.urlStr]];
    [_webView loadRequest:request];
    [_webView setDelegate:self];
    [self.view addSubview:_webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
