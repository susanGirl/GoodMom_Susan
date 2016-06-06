//
//  StoryDetailCell.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/27.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "StoryDetailCell.h"

@interface StoryDetailCell ()
///故事详情段落
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;


@end

@implementation StoryDetailCell

- (void)setDetail:(detailModel *)detail{
    
    if (_detail != detail) {
        _detail = nil;
        _detail  = detail;
        _detailLabel.text = detail.detailStr;
        NSLog(@"_detail.detailStr==%@",detail.detailStr);
        _detailLabel.numberOfLines = 0;
        CGRect rect = _detailLabel.frame;
        rect.size.height = ([[self class] textHeightWith:_detail] + 10);
        _detailLabel.frame = rect;
    }
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}





//计算标题的自适应高度
+ (CGFloat)textHeightWith:(detailModel *)detail{
    
    CGRect rect = [detail.detailStr boundingRectWithSize:CGSizeMake(414, 10000) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil];
    return rect.size.height;
}
+ (CGFloat)cellHeightWith:(detailModel *)detail{
    
    CGFloat height = [[self class]textHeightWith:detail];
    return height + 15;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
