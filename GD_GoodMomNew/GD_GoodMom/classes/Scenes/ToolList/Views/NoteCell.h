//
//  NoteCell.h
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteModel.h"
@interface NoteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@property(nonatomic,strong)NoteModel *note;

//自适应cell高度
+ (CGFloat )cellHeightWith:(NoteModel *)note;

@end
