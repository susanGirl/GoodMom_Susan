//
//  MyTopicCell.h
//  GD_GoodMom
//
//  Created by 80time on 16/6/6.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Topic.h"


@interface MyTopicCell : UITableViewCell

@property (strong, nonatomic) Topic *topic;

+ (CGFloat)cellHeight:(Topic *)topic;

@end
