//
//  Comment.h
//  GD_GoodMom
//
//  Created by 80time on 16/6/2.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

// 评论者名字
@property (strong, nonatomic) NSString *username;
// 评论者头像url
@property (strong, nonatomic) NSString *avatar;
// 评论的内容
@property (strong, nonatomic) NSString *content;
// 评论时间
@property (strong, nonatomic) NSString *commentDate;

@end
