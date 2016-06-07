//
//  PublishEditViewController.m
//  GD_GoodMom
//
//  Created by 80time on 16/5/24.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "PublishEditViewController.h"
#import "PlaceholderTextView.h"
#import "AddImagesView.h"
#import "LoginViewController.h"
#import <AVOSCloud/AVOSCloud.h>


// 相框宽度
#define kImagesViewW (kScreenW / 6.0)
// 相框高度
#define kImagesViewH (kImagesViewW * 3.0 / 4.0)
// 相框删除按钮的宽和高
#define kDeleteButtonW 15

@interface PublishEditViewController () <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    // 用来判断照片是否是全屏
    BOOL isFullScreen;
}

// 文本输入控件
@property (strong, nonatomic) PlaceholderTextView *textView;
// 添加图片控件
@property (strong, nonatomic) AddImagesView *addImagesView;
// 存放所有图片的数组
@property (strong, nonatomic) NSMutableArray *imagesArray;
// 存放所有相框的数组
@property (strong, nonatomic) NSMutableArray *imgViewsArray;
// 存放头像url
@property (strong, nonatomic) NSString *avatarURL;
// 要发布帖子的图片在本地的路径
@property (strong, nonatomic) NSString *totalPath;
// 要发布的帖子
@property (strong, nonatomic) AVObject *topic;


// 创建UIImagepickerController
@property (strong, nonatomic) UIImagePickerController *pickerController;
@end

@implementation PublishEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 文本输入控件
    [self setupTextView];
    // 添加照片控件
    [self setupImagesAction];
    // 设置导航栏
    [self setupNavigation];
    
}

#pragma mark -- 初始化存放照片的数组 -- 
- (NSMutableArray *)imagesArray {
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}
#pragma mark -- 添加照片 --
- (void)setupImagesAction {
    self.addImagesView = [AddImagesView new];
    self.addImagesView.width = self.view.width;
    self.addImagesView.y = self.view.height - self.addImagesView.height;
    [self.view addSubview:self.addImagesView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    UIButton *addImagesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addImagesButton.frame = CGRectMake(self.imagesArray.count * kImagesViewW, 0, kImagesViewW ,kImagesViewH);
    [addImagesButton setBackgroundImage:[UIImage imageNamed:@"addImages"] forState:UIControlStateNormal];
    [addImagesButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.addImagesView addSubview:addImagesButton];
}


#pragma mark -- 添加照片 --
- (void)addButtonClick {
    
    __weak typeof(self) weakSelf = self;
    
    // 设置最多只能添加5张照片
    if (self.imagesArray.count >= 5) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"最多只能添加5张照片！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    
    // 照片数量少于5张时，可以继续添加照片
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"获取照片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 调用相机
        [weakSelf invokeCamera];
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 调用相册
        [weakSelf invokeAlbum];

    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];

    [alertController addAction:cameraAction];
    [alertController addAction:albumAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}
#pragma mark -- 调用相机 --
- (void)invokeCamera {
    // 判断选择的模式是否是相机模式，如果没有相机弹出警告
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.pickerController = [UIImagePickerController new];
        // 设置代理
        self.pickerController.delegate = self;
        // 设置相机模式
        self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.pickerController animated:YES completion:nil];
    }else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"未检测到相机" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark -- 调用相册 --
// 调用相册
- (void)invokeAlbum {
    // 初始化
    self.pickerController = [UIImagePickerController new];
    // 设置代理
    self.pickerController.delegate = self;
    // 允许编辑图片
    self.pickerController.allowsEditing = YES;
    // 设置相册选完照片后，是否跳到编辑模式，进行图片编辑
    [self presentViewController:self.pickerController animated:YES completion:nil];
}

#pragma mark -- 调用相册和相机代理方法 --
// 点击选择按钮执行的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = nil;
    // 判断我们从哪里获取图片
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        // 修改前的image
        image = [info objectForKeyedSubscript:UIImagePickerControllerOriginalImage];
    }else {
        // 可编辑UIImagePickerControllerEditedImage(获取编辑后的图片）
        image = [info objectForKeyedSubscript:UIImagePickerControllerEditedImage];
    }

    // 创建相框和添加照片
    [self creatImgViewWithImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -- 创建相框和添加照片 --

- (void)creatImgViewWithImage:(UIImage *)image {
    
    // 初始化相框
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.imagesArray.count + 1) * kImagesViewW, 0, kImagesViewW, kImagesViewH)];
    // 设置相框圆角
    imgView.layer.cornerRadius = 10;
    imgView.layer.masksToBounds = YES;
    // 为相框设置图片
    imgView.image = image;
    // 相框添加到父视图
    [self.addImagesView addSubview:imgView];
    // 相框添加到数组
    [self.imgViewsArray addObject:imgView];
    // 照片添加到数组
    [self.imagesArray addObject:image];

    // 将图片保存到本地
    [self saveImage:imgView.image withName:[NSString stringWithFormat:@"%@", [NSDate date]]];
    
    
    // 为每一个相框添加删除按钮
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteButton.frame = CGRectMake(kImagesViewW - kDeleteButtonW, 0, kDeleteButtonW, kDeleteButtonW);
    [deleteButton setBackgroundImage:[UIImage imageNamed:@"deleteImages"] forState:UIControlStateNormal];
    // 为删除按钮添加事件
    [deleteButton addTarget:self action:@selector(deleteImageViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [imgView addSubview:deleteButton];
    // 打开用户交互，使删除按钮能够接受点击事件，删除相框。
    imgView.userInteractionEnabled = YES;
    
    
    
    // 保存图片url到服务器
    AVFile *file = [AVFile fileWithName:[NSString stringWithFormat:@"%@", self.topic.createdAt] contentsAtPath:self.totalPath];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
    } progressBlock:^(NSInteger percentDone) {
        
    }];

}

#pragma mark -- 保存要发布的图片 --
- (void)saveImage:(UIImage *)tempImage withName:(NSString *)imageName {
    NSData *imageData = UIImagePNGRepresentation(tempImage);
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    self.totalPath = [documentPath stringByAppendingPathComponent:imageName];
    // 保存到document
    [imageData writeToFile:self.totalPath atomically:YES];
}

#pragma mark -- 删除相框和图片数组中的图片 --
- (void)deleteImageViewAction:(UIButton *)button {
    NSLog(@"------2---%ld", self.addImagesView.imgViewArray.count);
    // 获取要删除的相框
    UIImageView *imgView = (UIImageView *)button.superview;
    // 将相框中的图片从图片数组中移除
    [self.imagesArray removeObject:imgView.image];
    // 将相框从相框数组中移除
    [self.imgViewsArray removeObject:imgView];
    // 将相框从父视图移除
    [imgView removeFromSuperview];
    NSLog(@"------3---%ld", self.imgViewsArray.count);
#warning 删除相框后，位置未更新成功。
    self.addImagesView.imgViewArray = self.imgViewsArray;
//    NSLog(@"------1---%ld", self.addImagesView.imgViewArray.count);
//    [self.addImagesView layoutSubviews];
    
//    for (UIImageView *imgView in self.addImagesView.subviews) {
//        [imgView removeFromSuperview];
//    }
//    for (UIImage *image in self.imagesArray) {
//        [self creatImgViewWithImage:image];
//    }
}


// 点击取消按钮执行的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


/**
 * 监听键盘的弹出和隐藏
 */
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 键盘最终的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.addImagesView.transform = CGAffineTransformMakeTranslation(0,  keyboardF.origin.y - kScreenH);
    }];
}

#pragma mark -- 添加发布内容 --
- (void)setupTextView {
    self.textView = [PlaceholderTextView new];
    self.textView.placeholder = @"育儿经验、情感状态、生活小技巧、时尚装扮...";
    self.textView.frame = self.view.bounds;
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
}

#pragma mark -- 设置导航栏 --
- (void)setupNavigation {
    
    // 导航栏标题
    self.title = @"发帖";
    // 导航栏左侧按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
    // 导航栏右侧按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(publishAction)];
    self.navigationItem.rightBarButtonItem.enabled = NO; // 默认不能点击
    // 强制刷新
    [self.navigationController.navigationBar layoutIfNeeded];
}

#pragma mark -- 取消发表 --
- (void)cancelAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 发表 --
- (void)publishAction {
    
    __weak PublishEditViewController *weakSelf = self;
    
    // 点击发表按钮时，先判断登录状态，如果处于已经登录，则直接发表。如果还没有登录，则跳转到登录页面。
    NSLog(@"%@", [AVUser currentUser]);
    NSLog(@"%@", [AVUser currentUser].username);
    NSLog(@"%@", [AVUser currentUser][@"hobby"]);
    
    // 判断当前用户登陆状态
    if ([AVUser currentUser] && [[AVUser currentUser][@"loginState"] boolValue] == YES) {
        // 如果当前用户处于登陆状态
        // 存储帖子内容到服务器
        // 创建存储对象
        AVObject *topic = [AVObject objectWithClassName:@"Topic"];
        [topic setObject:self.textView.text forKey:@"text"]; // 帖子的文字内容
        [topic setObject:self.topicTitle forKey:@"type"]; // 帖子的类型
        [topic setObject:[NSNumber numberWithInt:0] forKey:@"commentCount"]; // 帖子的评论人数
        [topic setObject:[NSNumber numberWithInt:0] forKey:@"collectionCount"]; // 帖子的收藏人数
        [topic setObject:[NSNumber numberWithInt:0] forKey:@"shareCount"]; // 帖子的分享人数
        [topic setObject:[AVUser currentUser].username forKey:@"username"]; // 发帖作者的昵称
        [topic setObject:[AVUser currentUser][@"babyGender"] forKey:@"babyGender"]; // 宝宝性别
        [topic setObject:[AVUser currentUser][@"babyBirthday"] forKey:@"babyBirthday"]; // 宝宝出生日期
        
        
        // 查询当前作者的头像的url
        AVQuery *query = [AVQuery queryWithClassName:@"_File"];
        [query whereKey:@"name" equalTo:[AVUser currentUser].username];
        NSArray *objects = [query findObjects];
        for (AVObject *obj in objects) {
            self.avatarURL = [obj[@"localData"] objectForKey:@"url"];
        }
        [topic setObject:self.avatarURL forKey:@"avatar"]; // 设置用户头像url
        self.topic = topic;
        
        // 存储到服务器
        [topic saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                
                // 存储成功
                NSLog(@"存储成功");
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"发表成功!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertController addAction:okAction];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            } else {
                // 存储失败
                NSLog(@"存储失败, 错误代码%@", error);
            }
        }];

    } else {
        // 如果没有用户登陆，即currentUser为空，则跳转到登陆页面
        LoginViewController *loginVC = [LoginViewController new];
        loginVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    
    
    
//    LoginViewController *loginVC = [LoginViewController new];
//    loginVC.block = ^(AVUser *user) {
//        if ([user[@"loginState"] boolValue] == YES) {
//            
//            // 存储帖子内容到服务器
//            // 创建存储对象
//            AVObject *topic = [AVObject objectWithClassName:@"Topic"];
//            [topic setObject:self.textView.text forKey:@"text"]; // 帖子的文字内容
//            [topic setObject:self.imagesArray forKey:@"images"]; // 帖子的图片内容
//            [topic setObject:self.topicTitle forKey:@"type"]; // 帖子的类型
//            //    [breedTopic setObject:@"挺好的帖子" forKey:@"comment"]; // 帖子的评论
//            [topic setObject:[NSNumber numberWithInt:5] forKey:@"commentCount"]; // 帖子的评论人数
//            [topic setObject:[NSNumber numberWithInt:16] forKey:@"collectionCount"]; // 帖子的收藏人数
//            [topic setObject:[NSNumber numberWithInt:38] forKey:@"shareCount"]; // 帖子的分享人数
//            [topic setObject:user.username forKey:@"username"]; // 发帖作者的昵称
//            // 存储
//            [topic saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                if (succeeded) {
//                    // 存储成功
//                    NSLog(@"存储成功");
//                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"发表成功!" preferredStyle:UIAlertControllerStyleAlert];
//                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                        [weakSelf dismissViewControllerAnimated:YES completion:nil];
//                    }];
//                    [alertController addAction:okAction];
//                    [weakSelf presentViewController:alertController animated:YES completion:nil];
//                } else {
//                    // 存储失败
//                    NSLog(@"存储失败, 错误代码%@", error);
//                }
//            }];
//        } else {
//            // 如果还未登陆，则跳转到登陆页面
//        }
//        
//    };
//    loginVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:loginVC animated:YES completion:nil];
    


}

#pragma mark -- 弹出键盘 --
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 先退出之前的键盘
    [self.view endEditing:YES];
    // 再叫出键盘
    [self.textView becomeFirstResponder];
}

#pragma mark -- <UITextViewDelegate> 代理方法 --
- (void)textViewDidChange:(UITextView *)textView {
    // 帖子内容改变时，发表按钮变成可以点击状态
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
    self.textView.placeholderLabel.hidden = textView.hasText;
  
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 开始滑动时，变成不可编辑状态
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
