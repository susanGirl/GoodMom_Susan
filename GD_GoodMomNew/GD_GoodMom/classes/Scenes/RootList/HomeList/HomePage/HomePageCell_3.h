//
//  HomePageCell_3.h
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/1.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WebViewController.h"

@interface HomePageCell_3 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *button_1;
@property (weak, nonatomic) IBOutlet UIButton *button_2;
@property (weak, nonatomic) IBOutlet UIButton *button_3;
@property(strong,nonatomic)NSString  *url_1;
@property(strong,nonatomic)NSString  *url_2;
@property(strong,nonatomic)NSString  *url_3;
@property(strong,nonatomic)NSString  *name_1;
@property(strong,nonatomic)NSString  *name_2;
@property(strong,nonatomic)NSString  *name_3;
@property(strong,nonatomic)UIViewController  *buttonVC;
@end
