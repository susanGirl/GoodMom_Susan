//
//  Topic.m
//  GD_GoodMom
//
//  Created by 80time on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "Topic.h"

// 间距
#define kCellMargin 5
// 文本y坐标值
#define kTextY 130
// 图片帖子的最大高度
#define kPictureMaxH 1000
// 图片帖子一旦超过最大高度,就是用Break
#define kPictureBreakH 250

@implementation Topic

- (void)setImages:(NSMutableArray *)images {
    if (_images != images) {
        _images = nil;
        _images = images;
        
        _images = [NSMutableArray array];
        
        // 获取存放帖子图片url的数组
        AVQuery *query = [AVQuery queryWithClassName:@"_File"];
        [query whereKey:@"name" equalTo:[NSString stringWithFormat:@"%@", self.creatAt]];
        NSArray *objects = [query findObjects];
        for (AVObject *obj in objects) {
           
            NSString *imageURL = [obj[@"localData"] objectForKey:@"url"];
            [self.images addObject:imageURL];
        }
    }
    
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", _text];
}


@end
