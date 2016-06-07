//
//  TopicCell.h
//  GD_GoodMom
//
//  Created by 80time on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Topic.h"

@interface TopicCell : UITableViewCell

@property (strong, nonatomic) Topic *topic;
// 收藏帖子的人数
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
// 评论帖子的人数
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
// cell高度的属性
@property (assign, nonatomic) CGFloat cellHeight;

// 计算cell高度
- (CGFloat)calculateCellHeight;

@end
