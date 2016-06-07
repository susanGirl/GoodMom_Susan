//
//  MeListCell.h
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;//头像

@property (weak, nonatomic) IBOutlet UILabel *userNameLable;
@property (weak, nonatomic) IBOutlet UIView *contentView;


-(void)updateToDaySkinMode;//日间模式
-(void)updateToNightSkinMode;//夜间模式

@end
