//
//  Lists.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/6.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "Lists.h"

@implementation Lists
- (void)setValue:(id)value forKey:(NSString *)key{
    
    key = [key isEqualToString:@"id"]?@"ID":key;
    [super setValue:value forKey:key];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

   
}
@end
