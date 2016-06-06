//
//  StoryDetailCell.h
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/27.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryDetailCell : UITableViewCell

@property(nonatomic,strong)detailModel *detail;

+ (CGFloat)cellHeightWith:(detailModel *)detail;
@end
