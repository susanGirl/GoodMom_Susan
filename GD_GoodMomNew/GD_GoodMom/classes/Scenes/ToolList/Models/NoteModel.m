//
//  NoteModel.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "NoteModel.h"

@implementation NoteModel
- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail date:(NSString *)date{
    if (self = [super init]) {
        _title = title;
        _detail = detail;
        _date = date;
        
    }
    return self;
}

+ (instancetype)NoteWithTitle:(NSString *)title detail:(NSString *)detail date:(NSString *)date{
    return [[self alloc]initWithTitle:title detail:detail date:date];
    
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
    
}
@end
