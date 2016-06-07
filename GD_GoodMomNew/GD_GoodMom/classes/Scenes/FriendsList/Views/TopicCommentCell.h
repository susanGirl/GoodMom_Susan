//
//  TopicCommentCell.h
//  GD_GoodMom
//
//  Created by 80time on 16/5/30.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"

@interface TopicCommentCell : UITableViewCell

@property (strong, nonatomic) Comment *comment;
// 计算cell高度
- (CGFloat)calculateCellHeight;
@end
