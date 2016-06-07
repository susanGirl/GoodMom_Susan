//
//  PersonalInformationCell.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/1.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "PersonalInformationCell.h"
#import <AVOSCloud/AVOSCloud.h>

@interface PersonalInformationCell ()

@end

@implementation PersonalInformationCell


-(void)setUser:(User *)user{

    if (_user != user) {
        _user = nil;
        _user = user;
        _userGender.clearButtonMode = UITextFieldViewModeAlways;
        _birsthdayTF.clearButtonMode = UITextFieldViewModeAlways;
        _hobbyTF.clearButtonMode = UITextFieldViewModeAlways;
        _genderTF.clearButtonMode = UITextFieldViewModeAlways;
#pragma mark--对当前用户相应的属性进行赋值
        AVUser *user = [AVUser currentUser];
        _genderTF.text = user[@"babyGender"];
        _userGender.text = user[@"userGender"];
        _hobbyTF.text = user[@"babyHobby"];
        _birsthdayTF.text = user[@"babybirthday"];
    }
}
#pragma mark---日间模式
-(void)updateToDaySkinMode{
    self.userNameLabel.backgroundColor = [UIColor whiteColor];
    self.userNameLabel.textColor = [UIColor blackColor];
    self.genderTF.backgroundColor = [UIColor whiteColor];
    self.genderTF.textColor = [UIColor blackColor];
    self.birsthdayTF.backgroundColor =  [UIColor whiteColor];
    self.birsthdayTF.textColor  = [UIColor blackColor];
    self.hobbyTF.backgroundColor = [UIColor whiteColor];
    self.hobbyTF.textColor = [UIColor blackColor];
    self.userGender.backgroundColor = [UIColor whiteColor];
    self.userGender.textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor whiteColor];
}
#pragma mark---夜间模式
-(void)updateToNightSkinMode{
    self.userNameLabel.backgroundColor = [UIColor colorWithRed:35/255.0 green:32/255.0 blue:36/255.0 alpha:1.0];
    self.userNameLabel.textColor = [UIColor colorWithRed:111/255.0 green:109/255.0 blue:112/255.0 alpha:1.0];
    self.genderTF.backgroundColor =  [UIColor colorWithRed:35/255.0 green:32/255.0 blue:36/255.0 alpha:1.0];
    self.genderTF.textColor =  [UIColor colorWithRed:111/255.0 green:109/255.0 blue:112/255.0 alpha:1.0];
    self.birsthdayTF.backgroundColor =   [UIColor colorWithRed:35/255.0 green:32/255.0 blue:36/255.0 alpha:1.0];
    self.birsthdayTF.textColor  =  [UIColor colorWithRed:111/255.0 green:109/255.0 blue:112/255.0 alpha:1.0];
    self.hobbyTF.backgroundColor =  [UIColor colorWithRed:35/255.0 green:32/255.0 blue:36/255.0 alpha:1.0];
    self.hobbyTF.textColor  = [UIColor colorWithRed:111/255.0 green:109/255.0 blue:112/255.0 alpha:1.0];
    self.userGender.backgroundColor =  [UIColor colorWithRed:35/255.0 green:32/255.0 blue:36/255.0 alpha:1.0];
    self.userGender.textColor =[UIColor colorWithRed:111/255.0 green:109/255.0 blue:112/255.0 alpha:1.0];
    self.backgroundColor =  [UIColor colorWithRed:35/255.0 green:32/255.0 blue:36/255.0 alpha:1.0];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
