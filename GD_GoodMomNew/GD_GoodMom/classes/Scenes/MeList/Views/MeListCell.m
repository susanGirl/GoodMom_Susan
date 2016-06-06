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



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
