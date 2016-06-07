//
//  HomeToolViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/1.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "HomeToolViewController.h"
#import "WebViewController.h"
@interface HomeToolViewController ()<UIWebViewDelegate>


@end

@implementation HomeToolViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    _childBook setBackgroundImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>
    
}
- (IBAction)button_1:(id)sender {
    [self pushWebView:@"http://www.mia.com/search/s?k=%E5%8F%89%E5%8B%BA"];
}
- (IBAction)button_2:(id)sender {
    [self pushWebView:@"http://www.mia.com/search/s?k=%E9%92%99%E7%89%87"];
}
- (IBAction)button_3:(id)sender {
    [self pushWebView:@"http://www.mia.com/search/s?cat=121"];
}
- (IBAction)button_4:(id)sender {
    [self pushWebView:@"http://www.mia.com/search/s?cat=145"];
}
- (IBAction)button_5:(id)sender {
    [self pushWebView:@"http://www.mia.com/search/s?cat=144"];
}
- (IBAction)button_6:(id)sender {
    [self pushWebView:@"http://www.mia.com/search/s?k=%E6%89%AD%E6%89%AD%E8%BD%A6"];
}
- (IBAction)button_7:(id)sender {
    [self pushWebView:@"http://www.mia.com/search/s?cat=190"];
}
- (IBAction)button_8:(id)sender {
    [self pushWebView:@"http://www.mia.com/search/s?cat=122"];
}
- (void)pushWebView:(NSString *)url{

    WebViewController *webViewVC = [WebViewController new];
    
    webViewVC.webView.scalesPageToFit = YES;// 是否自适应
    
    webViewVC.webViewUrl = url;
    
    [self.navigationController pushViewController:webViewVC animated:YES];
}



@end
