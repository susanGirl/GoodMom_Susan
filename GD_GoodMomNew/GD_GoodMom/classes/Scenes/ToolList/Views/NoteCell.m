//
//  NoteCell.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "NoteCell.h"

@implementation NoteCell

- (void)setNote:(NoteModel *)note{
    if (_note != note) {
        _note = nil;
        _note = note;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.titleLabel.text = note.title;
            self.dateLabel.text = note.date;
            
        });
        
    }
}
///计算cell的自适应高度
+ (CGFloat)cellHeightWith:(NoteModel *)note{
    
    CGFloat titleHeigeht = [[self class] titleHeightWith:note];
    return titleHeigeht + 26;
    
    
}

//计算标题的自适应高度
+ (CGFloat)titleHeightWith:(NoteModel *)note{
    
    CGRect rect = [note.title boundingRectWithSize:CGSizeMake(414, 10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]} context:nil];
    return rect.size.height;
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
