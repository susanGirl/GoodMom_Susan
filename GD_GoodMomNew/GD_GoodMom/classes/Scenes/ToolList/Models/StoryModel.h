//
//  StoryModel.h
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryModel : NSObject
///故事的标题
@property(nonatomic,strong)NSString *title;
///故事内容
@property(nonatomic,strong)NSString *detail;
///故事的图片
@property(nonatomic,strong)NSString *image;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)storyModelWithDictionary:(NSDictionary *)dict;

@end
