//
//  Topic.m
//  GD_GoodMom
//
//  Created by 80time on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "Topic.h"
#import "NSDate+HFExtension.h"

// 间距
#define kCellMargin 5
// 文本y坐标值
#define kTextY 130
// 图片帖子的最大高度
#define kPictureMaxH 1000
// 图片帖子一旦超过最大高度,就是用Break
#define kPictureBreakH 250

@implementation Topic

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSMutableArray *)commentsArray {
    if (!_commentsArray) {
        _commentsArray = [NSMutableArray array];
    }
    return _commentsArray;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", _text];
}


@end
