//
//  NoteModel.h
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteModel : NSObject

@property(nonatomic,strong)NSString *title;

@property(nonatomic,strong)NSString *detail;

@property(nonatomic,strong)NSString *date;

- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail date:(NSString *)date;

+ (instancetype)NoteWithTitle:(NSString *)title detail:(NSString *)detail date:(NSString *)date;

@end
