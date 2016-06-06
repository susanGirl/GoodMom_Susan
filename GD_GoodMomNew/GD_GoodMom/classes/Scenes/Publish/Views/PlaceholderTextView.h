//
//  PlaceholderTextView.h
//  GD_GoodMom
//
//  Created by 80time on 16/5/24.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView
// 占位文字
@property (copy, nonatomic) NSString *placeholder;
// 占位文字的颜色
@property (strong, nonatomic) UIColor *placeholderColor;
// 占位文字Label
@property (weak, nonatomic) UILabel *placeholderLabel;
@end
