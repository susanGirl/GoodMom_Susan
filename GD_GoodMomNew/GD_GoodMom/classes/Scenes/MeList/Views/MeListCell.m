//
//  MeListCell.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "MeListCell.h"

@implementation MeListCell

- (void)layoutSubviews
{
    self.imgView.layer.cornerRadius = 60;
    self.imgView.layer.masksToBounds = YES;
}

#pragma mark----日间模式
-(void)updateToDaySkinMode{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.userNameLable.backgroundColor = [UIColor whiteColor];
    self.userNameLable.textColor = [UIColor blackColor];
    

}
#pragma mark---夜间模式
-(void)updateToNightSkinMode{
    self.contentView.backgroundColor = [UIColor colorWithRed:35/255.0 green:32/255.0 blue:36/255.0 alpha:1.0];
    self.userNameLable.backgroundColor = [UIColor colorWithRed:35/255.0 green:32/255.0 blue:36/255.0 alpha:1.0];
    self.userNameLable.textColor  = [UIColor colorWithRed:111/255.0 green:109/255.0 blue:112/255.0 alpha:1.0];



}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
