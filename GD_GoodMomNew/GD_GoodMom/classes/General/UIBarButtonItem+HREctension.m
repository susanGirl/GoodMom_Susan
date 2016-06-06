//
//  UIBarButtonItem+HREctension.m
//  01-百思不得姐
//
//  Created by lanou3g on 16/5/20.
//  Copyright © 2016年 蓝欧. All rights reserved.
//

#import "UIBarButtonItem+HREctension.h"

@implementation UIBarButtonItem (HREctension)

+(id)itemWithImage:(NSString *)image heightImage:(NSString *)heightImage targe:(id)targe action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    [button setBackgroundImage:[UIImage imageNamed:heightImage] forState:(UIControlStateHighlighted)];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:targe action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
