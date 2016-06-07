//
//  DBHandle.h
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NoteModel;

@interface DBHandle : NSObject
#pragma mark 创建数据库单例对象
+(DBHandle *)sharedDBManager;
#pragma mark 打开数据库
- (void)openDB;
#pragma mark 关闭数据库
- (void)closeDB;
#pragma mark---创建表
- (void)createTable;
#pragma mark 添加日记
- (void)insertNoteWith:(NoteModel *)note;
#pragma mark 删除日记
- (void)deleteNoteWith:(NSString *)title;
#pragma mark 修改日记
- (void)upDateNoteWith:(NoteModel *)note withtitle:(NSString *)title;
#pragma mark 查询日记
- (NSMutableArray *)selectAllNote;

@end
