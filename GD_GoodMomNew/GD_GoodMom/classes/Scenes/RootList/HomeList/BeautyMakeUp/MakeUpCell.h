//
//  MakeUpCell.h
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/3.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakeUpCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView_1;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_2;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_3;
- (void)name:(NSString *)name_1 name:(NSString *)name_2 name:(NSString *)name_3;
@end
