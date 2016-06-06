//
//  DatabaseManager.h
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/30.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseManager : NSObject


#pragma mark 打开数据库
-(void)openDB;
#pragma mark 关闭数据库
-(void)closeDB;



@end
