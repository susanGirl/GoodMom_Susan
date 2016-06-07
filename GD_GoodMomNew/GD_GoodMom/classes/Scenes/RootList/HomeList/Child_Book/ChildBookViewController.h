//
//  ChildBookViewController.h
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildBookViewController : UIViewController
{
    
    UIWebView *webView;
    UIActivityIndicatorView *activityIndicator;
}
// 1
- (void )webViewDidStartLoad:(UIWebView *)webView;// 1.网页开始加载的时候调用
- (void )webViewDidFinishLoad:(UIWebView *)webView;// 2.网页加载完成的时候调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;// 3.网页加载错误的时候调用

@end
