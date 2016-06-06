//
//  ChildClothesViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/30.
//  Copyright © 2016年 温哲. All rights reserved.
//


#import "ChildClothesViewController.h"
#import "WebViewController.h"
#import "SVProgressHUD.h"
@interface ChildClothesViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end




@implementation ChildClothesViewController

- (void)viewWillAppear:(BOOL)animated{
    
    
//    self.navigationItem.leftBarButtonItem *button = [UIButton buttonWithType:(UIButtonType)]
//    self.navigationItem.title = @"童装";
//    WebViewController *webVC = [WebViewController new];
//    webVC.webViewUrl = @"http://m.mia.com/special/module/index/5094/app/";
//    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:COLOR_arc green:COLOR_arc blue:COLOR_arc alpha:1.0];
    
//    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, kScreenHeight-100)];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@""]];
//    
//    [webView setDelegate:self];
//    [self.view addSubview:webView];
//    [webView loadRequest:request];
    
    self.webView.delegate= self;
    NSURL *url = [NSURL URLWithString:@"http://m.mia.com/special/module/index/5094/app/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];

}

// 1.网页开始加载的时候调用
- (void )webViewDidStartLoad:(UIWebView *)webView{

    //创建UIActivityIndicatorView背底半透明View
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, kScreenHeight-100)];
//    [view setTag:108];
//    [view setBackgroundColor:[UIColor blackColor]];
//    [view setAlpha:0.5];
//    [self.view addSubview:view];
//    
//     activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
//    [activityIndicator setCenter:view.center];
//    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
//    [view addSubview:activityIndicator];
//    
//    
//    [activityIndicator startAnimating];

    [SVProgressHUD showWithStatus:@"正在加载中，请稍后。。。"];
    
    /*
    // Do something useful in the background and update the HUD periodically.
    NSString *str = @"var h1 = document.getElementsByTagName('h1')[0];""h1.innerHTML='小强哥哥鲜花网';";
    
    [self.webView stringByEvaluatingJavaScriptFromString:str];
    
    NSString *str1 =@"document.getElementById('footer').remove();";
    
    [self.webView stringByEvaluatingJavaScriptFromString:str1];
    */

}
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [SVProgressHUD dismiss];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD showErrorWithStatus:@"网络错误，请重新加载。。。"];
}

- (BOOL)prefersStatusBarHidden{
    
    return YES;
}
/*
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

*/
@end
