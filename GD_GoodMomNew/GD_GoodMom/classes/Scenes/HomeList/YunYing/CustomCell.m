//
//  CustomCell.m
//  LessonUI-15-collectionView
//
//  Created by lanou3g on 16/3/25.
//  Copyright © 2016年 LanouYanFa9(组织名称). All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self drawView];
    }
    return self;
}

- (void)drawView{

    [self.contentView addSubview:self.imgView];

}
- (UIImageView *)imgView{

    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
        _imgView.backgroundColor = [UIColor cyanColor];
        _imgView.contentMode = UIViewContentModeScaleToFill;
    }
    
    return _imgView;
}
// 所有视图在绘制时都会执行此方法
// 因为所有的cell重用标识符都是一样的，所以不同大小的cell从重用池获取cell的时候会给取出不相符的cell，由于视图每次的布局的时候都会触发此方法，所以可以覆写并且在此方法中校正
- (void)layoutSubviews{
    [super layoutSubviews];
    
//    self.imgView.frame = self.contentView.frame;// 或者
    self.imgView.frame = self.contentView.bounds;
}
@end
