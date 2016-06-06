//
//  UIBarButtonItem+HREctension.h
//  01-百思不得姐
//
//  Created by lanou3g on 16/5/20.
//  Copyright © 2016年 蓝欧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HREctension)

+ itemWithImage:(NSString *)image heightImage:(NSString *)heightImage targe:(id)targe action:(SEL)action;

@end
