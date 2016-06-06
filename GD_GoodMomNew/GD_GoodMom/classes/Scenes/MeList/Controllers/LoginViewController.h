//
//  LoginViewController.h
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>
#import "User.h"

// 传递user的block
typedef void(^PassUserBlock)(User *user);

@interface LoginViewController : UIViewController

// 定义block属性
@property (nonatomic, copy) PassUserBlock block;

@end
