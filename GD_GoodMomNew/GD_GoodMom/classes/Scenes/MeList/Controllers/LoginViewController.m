//
//  LoginViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import <AFNetworking.h>
#import "FileHandle.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置标题
    self.title = @"登录";
}

#pragma mark----登录按钮
- (IBAction)loginAction:(id)sender {
    
    __weak LoginViewController *loginVC = self;
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // 如果登录成功，退出登录页面
        if ([alert.message isEqualToString:@"登录成功"]) {
            [loginVC dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    // 添加到提示框
    [alert addAction:cancelAction];
    
    // 判断用户名和密码是否为空
    if ([_userNameTextField.text isEqualToString:@""] || [_passwordTextField.text isEqualToString:@""]) {
        
        alert.message = @"用户名或密码不能为空";
        [loginVC presentViewController:alert animated:YES completion:nil];
        
    } else {
        
        [AVUser logInWithUsernameInBackground:self.userNameTextField.text password:self.passwordTextField.text block:^(AVUser *user, NSError *error) {
            if (user != nil) {
                
                // 登录成功
                NSLog(@"登录成功");
                // 改变登录状态
                [user setObject:[NSNumber numberWithBool:YES] forKey:@"loginState"];
                // 保存状态到服务器
                [user saveInBackground];
                
                User *theUser = [User new];
                theUser.userName = user.username;
                theUser.loginState = user[@"loginState"];
                theUser.passWord = user.password;
                // 头像URL
                theUser.avatar = user[@"avatar"];
                
                // block传值，将user传递到“我的”页面
                loginVC.block(theUser);
                // 保存到本地
                [FileHandle saveUserInfo:theUser];
                
                // 登录成功，退出登录页面
                [loginVC dismissViewControllerAnimated:YES completion:nil];
                
//                AVQuery *avatarURLQuery = [AVQuery queryWithClassName:@"_File"];
//                [avatarURLQuery whereKey:@"name" equalTo:[AVUser currentUser].username];
//                [avatarURLQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//                    NSLog(@"----9---%@", objects);
//                    AVObject *user = objects.firstObject;
//                    NSString *avatarURL = [user objectForKey:@"avatar"];
//                    theUser.avatar = avatarURL;
//                    NSLog(@"---------2-----%@", theUser.avatar);
//                    
//
//                
//
//                }];
                
            } else {
                // 登录失败
                NSLog(@"登录失败，失败代码%@", error);
                if (error.code == 211) {
                    alert.message = @"用户名不存在!";
                    [loginVC presentViewController:alert animated:YES completion:nil];
                }else {
                    alert.message = @"登录失败!";
                    [loginVC presentViewController:alert animated:YES completion:nil];
                }
                
            }
        }];
    }

    
    
    // ==========================
//    __weak LoginViewController *loginVC = self;
//    
//    UIAlertController *alertControlller = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//        if ([alertControlller.message isEqualToString:@"登录成功"]) {
//            [loginVC dismissViewControllerAnimated:YES completion:nil];
//            
//        }
//        
//    }];
//    [alertControlller addAction:action];
//    
//    //判断用户名和密码是否为空
//    if ([_userNameTextField.text isEqualToString:@""] || [_passwordTextField.text isEqualToString:@""]) {
//        
//        alertControlller.message = @"用户名或密码不能为空";
//        [self presentViewController:alertControlller animated:YES completion:nil];
//        
//    }else{
//        
//        
//        [AVUser logInWithUsernameInBackground:self.userNameTextField.text password:self.passwordTextField.text block:^(AVUser *user, NSError *error) {
//            
//            if (user != nil) {
//                
//                alertControlller.message = @"登录成功";
//                User *user1 = [User new];
//                
//                user1.userName = _userNameTextField.text;
//                user1.password = _passwordTextField.text;
//                
//                
//                //存储数据到本地
//                [FileHandle saveUserInfo:user1];
//                NSLog(@"%@",user1);
//                    //传值
//                loginVC.completion(user1);
//                
//                 [loginVC dismissViewControllerAnimated:YES completion:nil];
//                
//                
//            }
//            
//        }];
//    
//    }
    // =========================================
    
}


#pragma mark------注册按钮
- (IBAction)registerAction:(id)sender {
    
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    registerVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:registerVC animated:YES completion:nil];
    
}
#pragma mark-----退出按钮
- (IBAction)exitAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark -- 点击空白处收回键盘
- (IBAction)tapEmpty:(id)sender {
    
    //键盘回收
    [_userNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

#pragma mark - UITextFeld Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //键盘回收
    return [_passwordTextField resignFirstResponder] | [_userNameTextField resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}



@end
