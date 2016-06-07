//
//  TopicCommentViewController.h
//  GD_GoodMom
//
//  Created by 80time on 16/5/30.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Topic.h"


@interface TopicCommentViewController : UITableViewController
@property (strong, nonatomic) Topic *topic;
// cell 高度
@property (assign, nonatomic) CGFloat cellHeight;
@end
