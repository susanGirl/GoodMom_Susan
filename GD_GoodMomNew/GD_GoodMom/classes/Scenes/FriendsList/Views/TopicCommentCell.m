//
//  TopicCommentCell.m
//  GD_GoodMom
//
//  Created by 80time on 16/5/30.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "TopicCommentCell.h"
#import <AVOSCloud/AVOSCloud.h>


// 间距
#define kCellMargin 5
// 头像高度
#define kAvatarH 40

@interface TopicCommentCell ()
// 头像
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
// 昵称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
// 评论
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end


@implementation TopicCommentCell

- (void)setComment:(Comment *)comment {
    if (_comment != comment) {
        _comment = nil;
        _comment = comment;
        
        self.nameLabel.text = _comment.username;
        self.commentLabel.text = _comment.content;
        
        AVFile *avatarFile = [AVFile fileWithURL:_comment.avatar];
        // 获取头像的缩略图
        [avatarFile getThumbnail:YES width:70 height:70 withBlock:^(UIImage *image, NSError *error) {
            self.avatarImageView.image = image;
        }];
    }
}

#pragma mark -- 设置Frame --
- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = kCellMargin;
    frame.size.width -= 2 * kCellMargin;
    frame.size.height -= kCellMargin;
    frame.origin.y += kCellMargin;
    [super setFrame:frame];
}

// 计算cell高度
- (CGFloat)calculateCellHeight {
    
    // 文本高度
    CGSize maxSize = CGSizeMake(kScreenW - 55 , 10000);
    // 计算文本的高度
    CGFloat textH = [self.commentLabel.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    // cell的高度（包含文字时）
    return textH + kAvatarH + 3 * kCellMargin;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
