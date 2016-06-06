//
//  StoryModel.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "StoryModel.h"

@implementation StoryModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
    
}
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
    
    
}
+ (instancetype)storyModelWithDictionary:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}

@end
