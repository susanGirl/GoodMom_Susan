//
//  MeTableViewController.h
//  TTNews
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MeTableViewControllerDelegate <NSObject>
@optional
- (void)shakeCanChangeSkin:(BOOL)status;

@end

@interface MeTableViewController : UITableViewController

@property(nonatomic, weak) id<MeTableViewControllerDelegate> delegate;

@property(nonatomic,strong)NSString *content;//属性传值
@end
