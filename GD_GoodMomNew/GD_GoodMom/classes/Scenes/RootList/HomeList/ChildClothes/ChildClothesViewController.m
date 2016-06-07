//
//  ChildClothesViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/30.
//  Copyright © 2016年 温哲. All rights reserved.
//


#import "ChildClothesViewController.h"
#import "WebViewController.h"

@interface ChildClothesViewController ()




@end




@implementation ChildClothesViewController
- (IBAction)button_1:(id)sender {
    WebViewController *webViewVC = [WebViewController new];
    
    webViewVC.webView.scalesPageToFit = YES;// 是否自适应
    
    webViewVC.webViewUrl = @"http://www.mia.com/special/module/index/5264/pc/";
    
    [self.navigationController pushViewController:webViewVC animated:YES];
}
- (IBAction)button_2:(id)sender {
    WebViewController *webViewVC = [WebViewController new];
    
    webViewVC.webView.scalesPageToFit = YES;// 是否自适应
    
    webViewVC.webViewUrl = @"http://www.mia.com/special/module/index/5262/pc/";
    
    [self.navigationController pushViewController:webViewVC animated:YES];
}
- (IBAction)button_3:(id)sender {
    WebViewController *webViewVC = [WebViewController new];
    
    webViewVC.webView.scalesPageToFit = YES;// 是否自适应
    
    webViewVC.webViewUrl = @"http://www.mia.com/special/module/index/5131/pc/";
    
    [self.navigationController pushViewController:webViewVC animated:YES];
}
- (IBAction)button_4:(id)sender {
    WebViewController *webViewVC = [WebViewController new];
    
    webViewVC.webView.scalesPageToFit = YES;// 是否自适应
    
    webViewVC.webViewUrl = @"http://www.mia.com/special/module/index/5130/pc/";
    
    [self.navigationController pushViewController:webViewVC animated:YES];
}
- (IBAction)button_5:(id)sender {
    WebViewController *webViewVC = [WebViewController new];
    
    webViewVC.webView.scalesPageToFit = YES;// 是否自适应
    
    webViewVC.webViewUrl = @"http://www.mia.com/special/module/index/5582/pc/";
    
    [self.navigationController pushViewController:webViewVC animated:YES];
}
- (IBAction)button_6:(id)sender {
    WebViewController *webViewVC = [WebViewController new];
    
    webViewVC.webView.scalesPageToFit = YES;// 是否自适应
    
    webViewVC.webViewUrl = @"http://www.mia.com/special/module/index/5583/pc/";
    
    [self.navigationController pushViewController:webViewVC animated:YES];
}




- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithRed:COLOR_arc green:COLOR_arc blue:COLOR_arc alpha:1.0];

    
    
}

@end
