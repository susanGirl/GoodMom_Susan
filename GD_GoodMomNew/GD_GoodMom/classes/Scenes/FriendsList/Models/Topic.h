//
//  Topic.h
//  GD_GoodMom
//
//  Created by 80time on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface Topic : AVObject

// 服务器自动创建的属性是createdAt/updatedAt/objectId

// 作者昵称
@property (strong, nonatomic) NSString *username;
// 作者头像
@property (strong, nonatomic) NSString *avatar;
// 宝宝性别
@property (strong, nonatomic) NSString *babyGender;
// 宝宝年龄
@property (strong, nonatomic) NSDate *babyBirthday;
// 帖子发布时间
@property (strong, nonatomic) NSDate *creatAt;
// 帖子的文字内容
@property (strong, nonatomic) NSString *text;
// 帖子的图片内容
@property (strong, nonatomic) NSMutableArray *images;
// 帖子的类型
@property (strong, nonatomic) NSString *type;
// 帖子的评论
@property (strong, nonatomic) NSMutableArray *commentsArray;
// 帖子的评论数量
@property (assign, nonatomic) NSInteger commentCount;
// 收藏帖子的人数
@property (assign, nonatomic) NSInteger collectionCount;
// 分享帖子的人数
@property (assign, nonatomic) NSInteger shareCount;


//// 图片宽度
//@property (assign, nonatomic) CGFloat width;
//// 图片高度
//@property (assign, nonatomic) CGFloat height;


@end
