//
//  MBProgressHUD+gifHUD.h
//  DouBanProject
//
//  Created by 80time on 16/5/10.
//  Copyright © 2016年 新科技. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

// MBProgressHUD的类目，扩展方法。
// 可以自定义菊花视图的大小和gif动画图片
@interface MBProgressHUD (gifHUD)

/**
 *  加载gif动画
 *
 *  @param frame   HUD视图的大小
 *  @param gifName gif图片的名字
 *  @param view    HUD显示在哪个view上
 */
+ (void)setupHUDWithFrame:(CGRect)frame
                  gifName:(NSString *)gifName
            andShowToView:(UIView *)view;
@end
