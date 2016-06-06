//
//  FileDataHandle.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "FileDataHandle.h"

@implementation FileDataHandle

#pragma mark 创建FileDateHandle的单例对象
static FileDataHandle *fileDataHandle;
+ (instancetype)shareFileDataHandel{
    if (fileDataHandle == nil) {
        fileDataHandle = [[[self class] alloc] init];
    }
    return fileDataHandle;
}

#pragma mark 数据库
#pragma mark 缓存文件夹
- (NSString *)cachesPath{
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    
}
#pragma mark 存储路径
- (NSString *)databaseFilePath:(NSString *)databaseName{
    
    NSLog(@"%@",[[self cachesPath] stringByAppendingPathComponent:databaseName]);
    return [[self cachesPath] stringByAppendingPathComponent:databaseName];
    
}


@end
