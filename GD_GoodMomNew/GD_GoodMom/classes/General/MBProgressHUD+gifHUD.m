//
//  MBProgressHUD+gifHUD.m
//  DouBanProject
//
//  Created by 80time on 16/5/10.
//  Copyright © 2016年 新科技. All rights reserved.
//

#import "MBProgressHUD+gifHUD.h"
#import <SDWebImage/UIImage+GIF.h> // 导入第三方库
#import "MyHeader.pch"
@implementation MBProgressHUD (gifHUD)

/**
 *  加载gif动画
 *
 *  @param frame   HUD视图的大小
 *  @param gifName gif图片的名字
 *  @param view    HUD显示在哪个view上
 */
+ (void)setupHUDWithFrame:(CGRect)frame
                  gifName:(NSString *)gifName
            andShowToView:(UIView *)view {
    
    UIImage *image = [UIImage sd_animatedGIFNamed:gifName];
    UIImageView *gifView = [[UIImageView alloc] initWithFrame:frame];
    gifView.image = image;
    
    MBProgressHUD *hud = [self showHUDAddedTo:view animated:YES]; // 添加hud到view
    hud.color = kRGBColor(0, 0, 0, 0.2); // 自定义颜色
    hud.mode = MBProgressHUDModeCustomView; // 自定义视图
    hud.labelText = @"数据处理中..."; // 自定义文字
    hud.customView = gifView; // 自定义图片视图
}

@end
