//
//  TopicViewController.h
//  GD_GoodMom
//
//  Created by 80time on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <UIKit/UIKit.h>

// 帖子类型
typedef NS_ENUM(NSUInteger, TopicType) {
    TopicTypeAll,
    TopicTypeBreed,
    TopicTypeEmotion,
    TopicTypeLife,
    TopicTypeFashion
};

@interface TopicViewController : UITableViewController
// 帖子类型
@property (assign, nonatomic) TopicType type;
@end
