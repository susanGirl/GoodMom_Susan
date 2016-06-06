//
//  StoryCell.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "StoryCell.h"
#import <UIImageView+WebCache.h>

@implementation StoryCell


- (void)setStory:(StoryModel *)story{
    
    if (_story != story) {
        _story = nil;
        _story = story;
        [_iconView sd_setImageWithURL:[NSURL URLWithString:_story.image] placeholderImage:[UIImage imageNamed:@"1"]];
        
        _titleLabel.text = _story.title;
    }
    
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
