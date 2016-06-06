//
//  AddImagesView.m
//  GD_GoodMom
//
//  Created by 80time on 16/5/24.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "AddImagesView.h"
#import "PublishEditViewController.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

// 相框宽度
#define kImagesViewW (kScreenW / 6.0)
// 相框高度
#define kImagesViewH kImagesViewW

@interface AddImagesView ()

@end
@implementation AddImagesView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(0, kScreenH - kImagesViewH, kScreenW, kImagesViewH);
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"%s", __FUNCTION__);
    
        for (int i = 0; i < self.imgViewArray.count; i++) {
            UIImageView *imgView = self.imgViewArray[i];
            imgView.x = (i + 1) * kImagesViewW;
        }
}

@end
