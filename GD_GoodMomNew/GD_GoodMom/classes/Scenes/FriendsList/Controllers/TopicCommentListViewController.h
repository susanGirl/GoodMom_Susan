//
//  TopicCommentListViewController.h
//  GD_GoodMom
//
//  Created by 80time on 16/6/1.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Topic.h"

@interface TopicCommentListViewController : UIViewController

@property (strong, nonatomic) Topic *topic;
// cell 高度
@property (assign, nonatomic) CGFloat cellHeight;

@end
