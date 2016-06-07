//
//  MakeUpCell.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/3.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "MakeUpCell.h"

@implementation MakeUpCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)name:(NSString *)name_1 name:(NSString *)name_2 name:(NSString *)name_3{
    _imgView_1.image = [UIImage imageNamed:name_1];
    _imgView_2.image = [UIImage imageNamed:name_2];
    _imgView_3.image = [UIImage imageNamed:name_3];
}
@end
