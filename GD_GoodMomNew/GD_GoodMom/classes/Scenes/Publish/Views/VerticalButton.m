//
//  VerticalButton.m
//  GD_GoodMom
//
//  Created by 80time on 16/5/24.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "VerticalButton.h"

@implementation VerticalButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

// 绘图
- (void)setup {
    // 按钮的标题居中显示
    self.titleLabel.textAlignment = NSTextAlignmentCenter;;
}

// 重新布局所有子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    // 设置图片位置和大小
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width; // 设置图片宽度和button宽度一样
    self.imageView.height = self.imageView.width; // 设置图片高度和宽度一样
    
    // 设置标题位置和大小
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}


- (void)awakeFromNib {
    [self setup];
}
@end
