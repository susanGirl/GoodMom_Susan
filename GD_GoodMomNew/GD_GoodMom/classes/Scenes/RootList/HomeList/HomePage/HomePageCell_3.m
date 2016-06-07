
//
//  HomePageCell_3.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/1.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "HomePageCell_3.h"

@implementation HomePageCell_3

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)action_1:(id)sender {
    WebViewController *webViewVC = [WebViewController new];
    
    webViewVC.webView.scalesPageToFit = YES;// 是否自适应
    
    webViewVC.webViewUrl = _url_1;
    
    webViewVC.name = _name_1;
    
    [_buttonVC.navigationController pushViewController:webViewVC animated:YES];
}
- (IBAction)action_2:(id)sender {
    WebViewController *webViewVC = [WebViewController new];
    
    webViewVC.webView.scalesPageToFit = YES;// 是否自适应
    
    webViewVC.webViewUrl = _url_2;
    
    webViewVC.name = _name_2;
    
    [_buttonVC.navigationController pushViewController:webViewVC animated:YES];
}
- (IBAction)action_3:(id)sender {
    WebViewController *webViewVC = [WebViewController new];
    
    webViewVC.webView.scalesPageToFit = YES;// 是否自适应
    
    webViewVC.webViewUrl = _url_3;
    
    webViewVC.name = _name_3;
    
    [_buttonVC.navigationController pushViewController:webViewVC animated:YES];
}

@end
