//
//  PersonalInformationCell.h
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/1.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface PersonalInformationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UITextField *genderTF;//宝宝性别
@property (weak, nonatomic) IBOutlet UITextField *birsthdayTF;//宝宝生日
@property (weak, nonatomic) IBOutlet UITextField *hobbyTF;//宝宝爱好
@property (weak, nonatomic) IBOutlet UITextField *userGender;//用户性别
@property(nonatomic,strong)User *user;

@property (weak, nonatomic) IBOutlet UIView *contentVIew;

-(void)updateToDaySkinMode;//日间模式
-(void)updateToNightSkinMode;//夜间模式
@end
