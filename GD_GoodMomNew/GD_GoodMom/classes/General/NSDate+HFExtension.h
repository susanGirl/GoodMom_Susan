//
//  NSDate+HFExtension.h
//  01-百思不得姐
//
//  Created by 80time on 16/5/9.
//  Copyright © 2016年 新科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HFExtension)

// 比较from和self的时间差值
- (NSDateComponents *)deltaFrom:(NSDate *)from;

// 判断是否是今年
- (BOOL)isThisYear;
// 判断是否是今天
- (BOOL)isToday;
// 判断是否是昨天
- (BOOL)isYesterday;
@end
