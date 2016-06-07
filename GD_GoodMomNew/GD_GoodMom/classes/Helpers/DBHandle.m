//
//  DBHandle.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "DBHandle.h"
#import <sqlite3.h>
#import "NoteModel.h"
#import "FileDataHandle.h"

//文件夹的名字
#define kDatabaseName @"Note.sqlite"

@implementation DBHandle

#pragma mark 创建数据库单例对象
static DBHandle *database = nil;
+(DBHandle *)sharedDBManager{
    if (nil == database) {
        database = [[[self class] alloc ]init];
        [database openDB];
    }
//    [database closeDB];
    return database;
    
}
#pragma mark 打开数据库
///创建数据库唯一的指针
static sqlite3 *db = nil;
- (void)openDB

{
    if (db) {
        
        return;
    }
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"noteNew.sqlite"];
    
    int result = sqlite3_open(path.UTF8String, &db);
    if (result == SQLITE_OK) {
        
        NSLog(@"打开数据库成功");
    }else{
        
        NSLog(@"打开数据库失败,错误代码%d",result);
        
    }
    
    
}

- (void)createTable
{
    NSString *sqWord = @"CREATE TABLE  IF NOT EXISTS   'noteNew' ('title' TEXT, 'detail' TEXT, 'date' TEXT PRIMARY KEY)";
    int result = sqlite3_exec(db, sqWord.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        
        NSLog(@"创建表成功");
    }
    else{
        
        NSLog(@"创建表失败,错误代码%d",result);
    }
    
}

#pragma mark 关闭数据库
- (void)closeDB{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库关闭成功");
        db = nil;
    }else{
        NSLog(@"数据库关闭失败");
    }
    
}

#pragma mark 添加日记
- (BOOL)insertNoteWith:(NoteModel *)note{
    
    sqlite3_stmt *stmt = nil;
    NSString *sql = @"insert into 'noteNew' values(?,?,?)";
    int result = sqlite3_prepare(db, sql.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, note.title.UTF8String, -1, NULL);
        sqlite3_bind_text(stmt, 2, note.detail.UTF8String, -1, NULL);
        sqlite3_bind_text(stmt, 3, note.date.UTF8String, -1, NULL);
        sqlite3_step(stmt);
        NSLog(@"插入数据成功");
        sqlite3_finalize(stmt);
        return YES;
    }else{
        sqlite3_finalize(stmt);
        NSLog(@"插入失败，错误%d",result);
        return NO;
    }
    return NO;
}
//#pragma mark 添加日记
//- (void)insertNoteWith:(NoteModel *)note{
//    
//    sqlite3_stmt *stmt = nil;
//    NSString *sql = @"insert into 'noteNew' values(?,?,?)";
//    int result = sqlite3_prepare(db, sql.UTF8String, -1, &stmt, NULL);
//    if (result == SQLITE_OK) {
//        sqlite3_bind_text(stmt, 1, note.title.UTF8String, -1, NULL);
//        sqlite3_bind_text(stmt, 2, note.detail.UTF8String, -1, NULL);
//        sqlite3_bind_text(stmt, 3, note.date.UTF8String, -1, NULL);
//        sqlite3_step(stmt);
//        NSLog(@"插入数据成功");
//    }else{
//        
//        NSLog(@"插入失败，错误%d",result);
//    }
//    sqlite3_finalize(stmt);
//
//    
//}
#pragma mark 删除日记
- (void)deleteNoteWith:(NSString  *)title{
    

    sqlite3_stmt *stmt = nil;
    NSString *sql = @"delete from 'noteNew' where title = ?";
    int result = sqlite3_prepare(db, sql.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, title.UTF8String, -1, NULL);
        if (sqlite3_step(stmt ) == SQLITE_DONE) {
                 NSLog(@"删除成功");
        }
    }else{
        NSLog(@"删除失败，错误%d",result);
    }
    sqlite3_finalize(stmt);
    
}
#pragma mark 修改日记
- (void)upDateNoteWith:(NoteModel *)note withtitle:(NSString *)title{
    

    
    sqlite3_stmt *stmt = nil;
    NSString *sql = @"update 'noteNew' set title = ? , detail = ? , date = ? where title = ?";
    int result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        if (sqlite3_step(stmt) == SQLITE_ROW) {///如果有这一行，则进行修改
            sqlite3_bind_text(stmt, 2, note.title.UTF8String, -1, NULL);
            sqlite3_bind_text(stmt, 3, note.detail.UTF8String, -1, NULL);
            sqlite3_bind_text(stmt, 4, note.date.UTF8String, -1, NULL);
            sqlite3_bind_text(stmt, 1, title.UTF8String, -1, NULL);

        }
        NSLog(@"修改成功");
    }else{
        
        NSLog(@"修改失败，代码%d",result);
    }
    
    sqlite3_finalize(stmt);
}
#pragma mark 查询日记
- (NSMutableArray *)selectAllNote{
    [self openDB];
    sqlite3_stmt *stmt = nil;
    NSString *sql = [NSString stringWithFormat:@"select *from 'noteNew'"] ;
    int result = sqlite3_prepare(db, sql.UTF8String, -1, &stmt, NULL);
    NSMutableArray *noteArray = nil;
    if ( result == SQLITE_OK) {
        noteArray = [NSMutableArray array];
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NoteModel *note = [NoteModel new];
            note.title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            note.detail = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            note.date = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            NSLog(@"===%@",note);
            [noteArray addObject:note];
        }
    }

    sqlite3_finalize(stmt);
    [self closeDB];
    return noteArray;
    
}

@end
