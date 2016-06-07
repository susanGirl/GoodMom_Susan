//
//  TopicCommentCell.m
//  GD_GoodMom
//
//  Created by 80time on 16/5/30.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "TopicCommentCell.h"


@interface TopicCommentCell ()
// 头像
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
// 昵称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
// 评论
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end


@implementation TopicCommentCell


- (void)setTopic:(Topic *)topic {
    if (_topic != topic) {
        _topic = nil;
        _topic = topic;
        
//        _nameLabel.text = self.topic.username;
        _nameLabel.text = @"温哲222";
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
