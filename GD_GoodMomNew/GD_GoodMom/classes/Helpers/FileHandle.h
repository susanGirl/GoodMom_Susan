//
//  FileHandle.h
//  DouBanProject
//
//  Created by lanou3g on 16/5/13.
//  Copyright © 2016年 庄辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface FileHandle : NSObject

#pragma mark - 方法
+ (instancetype)shareInstance;

// 保存用户信息
+ (void)saveUserInfo:(User *)user;
// 获取用户信息
+ (User *)getUserInfo;
// 注销用户信息
+ (void)removeUserInfo;

#pragma mark 数据库
#pragma mark 缓存文件夹
-(NSString *)cachesPath;
#pragma mark 数据库路径
-(NSString *)databaseFielePath:(NSString *)databaseName;



@end
