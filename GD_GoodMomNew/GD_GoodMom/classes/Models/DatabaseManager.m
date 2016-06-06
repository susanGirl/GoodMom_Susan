
//
//  DatabaseManager.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/30.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "DatabaseManager.h"
#import <sqlite3.h>
#import "FileHandle.h"

@implementation DatabaseManager

#pragma mark--- 创建单例对象
static DatabaseManager *handle = nil;
-(DatabaseManager *)shareInstance{

    if (nil == handle) {
        
        handle = [[[self class]alloc]init];
        [self openDB];
    }
    return handle;
}

#pragma mark 打开数据库
static  sqlite3 *db = nil;
-(void)openDB{

    if (db != nil) {
        return;
        
    }
    //数据库存储在沙盒中的caches的文件夹下
    NSString *dbpath = [[FileHandle shareInstance] databaseFielePath:@"GD_GoodMom.sqlite"];
    //打开数据库，第一个参数是数据库存储的完整的路径
    //如果数据库文件已经存在，是打开操作。如果数据库文件不存在，是先创建再打开
    int result = sqlite3_open([dbpath UTF8String], &db);
    if (result == SQLITE_OK) {
        
        /**
         *  创建表
         */
        
        NSString *createSql = @"CREATE TABLE ‘mom’ ('userName' TEXT, 'imageUrl' BLOB";
        //执行sql语句
        sqlite3_exec(db, createSql.UTF8String, NULL, NULL, NULL);
        
    }
    
}
//关闭数据库
-(void)closeDB{
     
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库关闭成功");
        db = nil;
    }
}


@end
