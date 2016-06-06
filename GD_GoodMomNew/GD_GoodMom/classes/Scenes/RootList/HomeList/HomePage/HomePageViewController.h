//
//  HomePageViewController.h
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^Completion)(NSData *data);

@interface HomePageViewController : UIViewController

@property(copy,nonatomic)Completion  block;

@end
