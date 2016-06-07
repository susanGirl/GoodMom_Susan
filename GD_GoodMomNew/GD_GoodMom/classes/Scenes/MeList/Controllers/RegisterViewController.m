//
//  RegisterViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "RegisterViewController.h"
#import <AFNetworking.h>
#import "imageNetWork.h"
#import <UIImageView+WebCache.h>
#import <AVOSCloud/AVOSCloud.h>
#import "User.h"
#import "MBProgressHUD+gifHUD.h"

@interface RegisterViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;//用户名

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;//密码
@property (weak, nonatomic) IBOutlet UITextField *repasswordTextField;//重复输入密码
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property(nonatomic,strong)UIImagePickerController *imagePicker;//图片选择器
// 头像本地存储路径
@property (strong, nonatomic) NSString *totalPath;
// 头像的网络url
@property (strong, nonatomic) NSString *avatarURL;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置标题
    self.title = @"注册";
    
    // 初始化（通过代理取本地相册图片）
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    
    // 打开avatarImageView用户交互
    self.avatarImageView.userInteractionEnabled = YES;
    
    
    
}


#pragma mark---调用相册的协议方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{

    // 获取本地相册图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage]; // UIImagePickerControllerEditedImage:编辑后的图片
    // 显示图片
    self.avatarImageView.image = image;
    // 保存图片
    [self saveImage:self.avatarImageView.image withName:[AVUser currentUser].username];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(saveImage), nil); // 将相机拍摄的照片保存到相册
    }
    
    // 隐藏图片选择页面
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 保存头像图片 --
- (void)saveImage:(UIImage *)tempImage withName:(NSString *)imageName {
    NSData *imageData = UIImagePNGRepresentation(tempImage);
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    self.totalPath = [documentPath stringByAppendingPathComponent:imageName];
    // 保存到document
    [imageData writeToFile:self.totalPath atomically:YES];
}

// 存图片时要执行的操作
- (void)saveImage {
    NSLog(@"存图片时要执行的操作");
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //隐藏图片选择页面
    [self dismissViewControllerAnimated:YES completion:nil];
}

//注册按钮
- (IBAction)registerAction:(id)sender {
    
    __weak RegisterViewController *weakRegisterVC = self;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    
    if ([self.userNameTextField.text isEqualToString:@""]) {
        // 密码不能为空
        alertController.message = @"用户名不能为空!";
        // 弹出提示框
        [self presentViewController:alertController animated:YES completion:nil];
    } else if ([self.passwordTextField.text isEqualToString:@""] || self.passwordTextField.text.length < 6) {
        // 密码不能为空,且要小于六位
        alertController.message = @"密码不能小于六位!";
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (![self.repasswordTextField.text isEqualToString:self.passwordTextField.text]) {
        // 两次密码不一致
        alertController.message = @"两次密码不一致，请重新输入!";
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
 
        // 显示缓冲进度条
        [MBProgressHUD setupHUDWithFrame:CGRectMake(0, 0, 90, 80) gifName:@"pika" andShowToView:weakRegisterVC.view];
#warning 判断头像路径是否存在
        // 设置头像
        // 如果沙盒中存在头像路径，才执行存储头像路径到服务器的代码
        
        // 向服务器发送注册信息
        // 新建AVUser对象实例
        AVUser *user = [AVUser user];
        if (self.totalPath != nil) {
            AVFile *file = [AVFile fileWithName:user.username contentsAtPath:self.totalPath];
            [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                // 设置用户名
                user.username = self.userNameTextField.text;
                // 设置密码
                user.password = self.passwordTextField.text;
                [user setObject:file.url forKey:@"avatar"];
                // 设置宝宝性别
                [user setObject:@"男宝宝" forKey:@"babyGender"];
                
                // 设置收藏帖子的数组
                NSMutableArray *collectionTopics = [NSMutableArray array];
                [user setObject:collectionTopics forKey:@"collectionTopics"];
                
                // 设置爱好
                [user setObject:@"吃饭睡觉打豆豆" forKey:@"hobby"];
                
                // 设置登录状态
                [user setObject:[NSNumber numberWithBool:NO] forKey:@"loginState"];
                // 注册
                [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        
                        // 存储成功后结束缓冲进度条
                        [MBProgressHUD hideHUDForView:weakRegisterVC.view animated:YES];
                        
                        // 注册成功
                        UIAlertController *okRegisterAlertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"恭喜您注册账号成功，请牢记用户名和密码" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okRegisterAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            // 注册成功，跳转到登录页面
                            [self dismissViewControllerAnimated:YES completion:nil];
                        }];
                        [okRegisterAlertController addAction:okRegisterAction];
                        // 弹出注册成功提示框
                        [self presentViewController:okRegisterAlertController animated:YES completion:nil];
                    } else {
                        // 注册失败
                        NSLog(@"%@", error.description);
                        if (error.code == 202) {
                            alertController.message = @"用户名已存在!";
                            [self presentViewController:alertController animated:YES completion:nil];
                        }
                    }
                }];
                
            }];
        }
        
    }
}

/**
 *  点击头像执行方法
 *
 *  @param sender
 */
- (IBAction)tapAvatarViewAction:(id)sender {
    
    // 添加AlertSheet
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 指定资源类型
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        self.imagePicker.allowsEditing = YES; // 允许编辑
        // 点击头像时弹出图片选择器
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction *cameralAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 指定资源类型
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePicker.allowsEditing = YES; // 允许编辑
        // 点击头像时弹出图片选择器
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    // 添加
    [alert addAction:photoAction];
    [alert addAction:cameralAction];
    [alert addAction:cancelAction];
    
    // 显示alertController
    [self presentViewController:alert animated:YES completion:nil];

 }

#pragma mark----退出按钮
- (IBAction)exitAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [_userNameTextField resignFirstResponder] | [_passwordTextField resignFirstResponder] | [_repasswordTextField resignFirstResponder];
}

- (IBAction)tapEmpty:(id)sender {
    
    //键盘回收
    [_userNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_repasswordTextField resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
