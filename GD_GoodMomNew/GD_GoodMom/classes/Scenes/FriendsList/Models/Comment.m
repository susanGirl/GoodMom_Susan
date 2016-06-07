//
//  Comment.m
//  GD_GoodMom
//
//  Created by 80time on 16/6/2.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "Comment.h"

@implementation Comment

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
- (NSString *)description {
    return [NSString stringWithFormat:@"%@", _content];
}
@end
