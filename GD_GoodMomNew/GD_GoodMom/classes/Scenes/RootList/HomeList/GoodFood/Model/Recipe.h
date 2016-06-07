//
//  Recipe.h
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/6.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject
@property(strong,nonatomic)NSString  *title;
@property(strong,nonatomic)NSString  *image;
@property(strong,nonatomic)NSString  *thumb_path;
@property(strong,nonatomic)NSString  *photo_path;
@property(strong,nonatomic)NSArray  *tags;
@property(strong,nonatomic)NSString  *tips;
@property(strong,nonatomic)NSString  *cookstory;
@property(strong,nonatomic)NSArray  *cookstep;
@property(strong,nonatomic)NSString  *cook_time;
@property(strong,nonatomic)NSString  *cook_difficulty;
@property(strong,nonatomic)NSString  *clicks;
@property(strong,nonatomic)NSArray  *major;
@property(strong,nonatomic)NSArray  *minor;
@property(strong,nonatomic)NSString  *author;
@property(strong,nonatomic)NSString  *author_photo;
@property(strong,nonatomic)NSString  *vu;



@end
