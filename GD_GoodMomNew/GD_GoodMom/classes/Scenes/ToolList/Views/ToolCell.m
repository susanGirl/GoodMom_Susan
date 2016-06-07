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
        _titleLabel.textColor = [UIColor colorWithRed:255/255.0 green:91/255.0 blue:197/255.0 alpha:1.0];
        _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:23];
        _iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",tool.iconImage]];
        
    }
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
   
}

@end
