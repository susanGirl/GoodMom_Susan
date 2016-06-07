//
//  VideoListsCell.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/6.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "VideoListsCell.h"

#import <UIImageView+WebCache.h>
@interface VideoListsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *videoImgView;
@property (weak, nonatomic) IBOutlet UIImageView *authorImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;


@end
@implementation VideoListsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setList:(Lists *)list{

    if (_list != list) {
        _list = nil;
        _list = list;
    }
    [_videoImgView sd_setImageWithURL:[NSURL URLWithString:list.pic]];
    [_authorImgView sd_setImageWithURL:[NSURL URLWithString:list.author_pic]];
    _titleLabel.text = list.name;
    NSString *introText = [list.intro stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    _collectionNumberLabel.text = introText;
    _authorNameLabel.text = list.author_name;
    _authorImgView.layer.cornerRadius = _authorImgView.frame.size.width/2;
    _authorImgView.layer.masksToBounds = YES;
}

@end
