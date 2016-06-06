//
//  FileHandle.m
//  DouBanProject
//
//  Created by lanou3g on 16/5/13.
//  Copyright © 2016年 庄辉. All rights reserved.
//

#import "FileHandle.h"

@implementation FileHandle

// 存储对象类型（方法宏）
#define kUserDefaults(object, key) [[NSUserDefaults standardUserDefaults] setObject:object forKey:key]
// 存储BOOL类型
#define kBoolUserDefaults(value, key) [[NSUserDefaults standardUserDefaults] setBool:value forKey:key]
// 获取对象类型
#define kGetObjectUserDefaults(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
// 获取BOOL类型
#define kGetBoolUserDefaults(key) [[NSUserDefaults standardUserDefaults] boolForKey:key]

static FileHandle *fileDataHandle = nil;
+ (instancetype)shareInstance
{
    if (fileDataHandle == nil) {
        fileDataHandle = [[[self class] alloc] init];
    }
    return fileDataHandle;
}


// 保存用户信息
+ (void)saveUserInfo:(User *)user {
    
    // 存储用户信息
    kUserDefaults(user.userName, @"userName");
    kUserDefaults(user.passWord, @"passWord");
    kBoolUserDefaults(user.loginState, @"loginState");
    kUserDefaults(user[@"avatar"], @"avatar");
    
}

// 获取用户信息
+ (User *)getUserInfo {
    
    User *user = [User new];
    user.userName = kGetObjectUserDefaults(@"userName");
    user.passWord = kGetObjectUserDefaults(@"passWord");
    user.loginState = kGetBoolUserDefaults(@"loginState");
    user.avatar = kGetObjectUserDefaults(@"avatar");
    return user;
}

// 注销用户信息
+ (void)removeUserInfo {
    
    kUserDefaults(nil, @"userName");
    kUserDefaults(nil, @"passWord");
    kBoolUserDefaults(NULL, @"loginState");
    kUserDefaults(nil, @"avatar");
}

#pragma mark 数据库缓存
#pragma mark  缓存文件夹
-(NSString *)cachesPath{

    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];

}
#pragma mark 数据库路径
-(NSString *)databaseFielePath:(NSString *)databaseName{

    return [[self cachesPath]stringByAppendingPathComponent:databaseName];

}


@end
