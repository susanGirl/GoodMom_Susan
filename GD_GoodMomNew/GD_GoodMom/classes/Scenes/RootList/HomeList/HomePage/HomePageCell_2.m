//
//  HomePageCell_2.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/1.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "HomePageCell_2.h"
#import "WebViewController.h"
@interface HomePageCell_2()
@property(strong,nonatomic)WebViewController  *webView;
@end
@implementation HomePageCell_2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setWebView:(WebViewController *)webView{
    
    if (_webView != webView) {
        _webView = nil;
        _webView = webView;
    }
    
}


- (IBAction)action_1:(id)sender {
    
    WebViewController *webViewVC = [WebViewController new];
    
    webViewVC.webView.scalesPageToFit = YES;// 是否自适应
    
    webViewVC.webViewUrl = _url_1;
    
    webViewVC.name = _name_1;
    
    [_buttonVC.navigationController pushViewController:webViewVC animated:YES];
    
}
- (IBAction)actino_2:(id)sender {
    WebViewController *webViewVC = [WebViewController new];
    
    webViewVC.webView.scalesPageToFit = YES;// 是否自适应
    
    webViewVC.webViewUrl = _url_2;
    
    webViewVC.name = _name_2;
    
    [_buttonVC.navigationController pushViewController:webViewVC animated:YES];
}

@end
