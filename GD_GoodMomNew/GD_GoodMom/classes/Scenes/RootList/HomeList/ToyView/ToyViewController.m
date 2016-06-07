//
//  ToyViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/1.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "ToyViewController.h"
#import "WebViewController.h"

@interface ToyViewController ()<UIWebViewDelegate>


@end

@implementation ToyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    _childBook setBackgroundImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>
    
}
- (IBAction)button_1:(id)sender {
    WebViewController *webViewVC = [WebViewController new];
    
    webViewVC.webView.scalesPageToFit = YES;// 是否自适应
    
    webViewVC.webViewUrl = @"http://www.mia.com/search/s?k=%E7%8E%A9%E5%85%B7%E5%88%86%E7%B1%BB&b=416&sp=0,0,0";
    
    [self.navigationController pushViewController:webViewVC animated:YES];
}
- (IBAction)button_2:(id)sender {
    WebViewController *webViewVC = [WebViewController new];
    
    webViewVC.webView.scalesPageToFit = YES;// 是否自适应
    
    webViewVC.webViewUrl = @"http://www.mia.com/search/s?k=%E7%8E%A9%E5%85%B7%E5%88%86%E7%B1%BB&b=681&sp=0,0,0";
    
    [self.navigationController pushViewController:webViewVC animated:YES];
}
- (IBAction)button_3:(id)sender {
    WebViewController *webViewVC = [WebViewController new];
    
    webViewVC.webView.scalesPageToFit = YES;// 是否自适应
    
    webViewVC.webViewUrl = @"http://www.mia.com/search/s?k=%E7%8E%A9%E5%85%B7%E5%88%86%E7%B1%BB&b=3708&sp=0,0,0";
    
    [self.navigationController pushViewController:webViewVC animated:YES];
}
- (IBAction)button_4:(id)sender {
    WebViewController *webViewVC = [WebViewController new];
    
    webViewVC.webView.scalesPageToFit = YES;// 是否自适应
    
    webViewVC.webViewUrl = @"http://www.mia.com/search/s?k=%E7%8E%A9%E5%85%B7%E5%88%86%E7%B1%BB&b=1447&sp=0,0,0";
    
    [self.navigationController pushViewController:webViewVC animated:YES];
}
- (IBAction)button_5:(id)sender {
    WebViewController *webViewVC = [WebViewController new];
    
    webViewVC.webView.scalesPageToFit = YES;// 是否自适应
    
    webViewVC.webViewUrl = @"http://www.mia.com/search/s?k=%E7%8E%A9%E5%85%B7%E5%88%86%E7%B1%BB&b=329&sp=0,0,0";
    
    [self.navigationController pushViewController:webViewVC animated:YES];
}
- (IBAction)button_6:(id)sender {
    WebViewController *webViewVC = [WebViewController new];
    
    webViewVC.webView.scalesPageToFit = YES;// 是否自适应
    
    webViewVC.webViewUrl = @"http://www.mia.com/search/s?k=%E7%8E%A9%E5%85%B7%E5%88%86%E7%B1%BB&b=143&sp=0,0,0";
    
    [self.navigationController pushViewController:webViewVC animated:YES];
}

- (IBAction)button_7:(id)sender {
    WebViewController *webViewVC = [WebViewController new];
    
    webViewVC.webView.scalesPageToFit = YES;// 是否自适应
    
    webViewVC.webViewUrl = @"http://www.mia.com/search/s?k=%E7%8E%A9%E5%85%B7%E5%88%86%E7%B1%BB&b=344&sp=0,0,0";
    
    [self.navigationController pushViewController:webViewVC animated:YES];
}



@end
