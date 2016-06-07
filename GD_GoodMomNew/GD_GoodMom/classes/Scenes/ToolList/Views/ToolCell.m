//
//  ToolCell.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/23.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "ToolCell.h"

@implementation ToolCell


- (void)setTool:(ToolModel *)tool{
    
    if (_tool != tool) {
        _tool = nil;
        _tool = tool;
        _titleLabel.text = tool.title;
        _iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",tool.iconImage]];
    }
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
   
}

@end
