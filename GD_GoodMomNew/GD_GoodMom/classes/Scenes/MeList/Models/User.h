//
//  User.h
//  GD_GoodMom
//
//  Created by 80time on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "AVUser.h"

@interface User : AVUser

// 服务器user自带username/password/email属性
@property (strong, nonatomic) NSString *userName; // 用户名
@property (strong, nonatomic) NSString *passWord; // 密码
@property (strong, nonatomic) NSString *avatar; // 头像
@property (assign, nonatomic) BOOL loginState; // 是否登录
@property (strong, nonatomic) NSString *hobby; // 爱好
@property (strong, nonatomic) NSString *babyGender; // 宝宝性别
@property (strong, nonatomic) NSString *babyBirthday; // 宝宝出生日期
@property (strong, nonatomic) NSString *momBirthday; // 妈妈出生日期
@property (assign, nonatomic) NSInteger concernCount; // 关注作者的人数

@end
