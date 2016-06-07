//
//  CustomTabBar.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/23.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "CustomTabBar.h"
#import "PublishViewController.h"

@interface CustomTabBar ()
@property(nonatomic,strong)  UIButton *publishButton;

@end
@implementation CustomTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIButton *publishButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.publishButton = publishButton;
        [publishButton setBackgroundImage:[UIImage imageNamed:@
                                           "publish"] forState:(UIControlStateNormal)];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"publish-H"] forState:(UIControlStateHighlighted)];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        publishButton.size = publishButton.currentBackgroundImage.size;
        [self addSubview:publishButton];
    }
    return self;
}

#pragma mark -- 发布按钮事件 --
- (void)publishClick {
    // 模态出发帖控制器
    PublishViewController *publishVC = [PublishViewController new];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVC animated:NO completion:nil];
}

- (void)layoutSubviews{

    [super layoutSubviews];
    //设置发布按钮的frame
    CGFloat width = self.width;
    CGFloat height = self.height;
    //    self.publishButton.width = _publishButton.currentBackgroundImage.size.width;
    //    self.publishButton.height = _publishButton.currentBackgroundImage.size.height;
    
    self.publishButton.center = CGPointMake(width * 0.5 , height * 0.5);
    //设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height ;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        //        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        
        if(![button isKindOfClass:[UIControl class]] || button == self.publishButton)continue;
        {
            //计算按钮的x值
            CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) :index) ;
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            //增加索引
            index++;
        }
    }
}




@end
