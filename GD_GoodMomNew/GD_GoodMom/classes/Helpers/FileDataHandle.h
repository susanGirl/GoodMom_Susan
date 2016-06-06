//
//  FileDataHandle.h
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileDataHandle : NSObject

#pragma mark 创建FileDateHandle的单例对象
+ (instancetype)shareFileDataHandel;

#pragma mark 数据库
#pragma mark 缓存文件夹
- (NSString *)cachesPath;
#pragma mark 存储路径
- (NSString *)databaseFilePath:(NSString *)databaseName;

@end
