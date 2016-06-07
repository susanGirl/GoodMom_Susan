//
//  PublishViewController.m
//  GD_GoodMom
//
//  Created by 80time on 16/5/24.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "PublishViewController.h"
#import "VerticalButton.h"
#import <POP.h>
#import "PublishEditViewController.h"



@interface PublishViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 让控制器的view不能被点击
    self.view.userInteractionEnabled = NO;
    // 帖子分类
    NSArray *imagesArrray = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titlesArray = @[@"孕育", @"情感", @"生活", @"时尚"];
    
    // 设置按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartX = 20;
    CGFloat buttonStartY = (kScreenH - 2 * buttonH) * 0.5;
    // x方向间距
    CGFloat xMargin = (kScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i < titlesArray.count; i++) {
        // 创建button
        VerticalButton *button = [[VerticalButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        // 设置button图片和标题
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titlesArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imagesArrray[i]] forState:UIControlStateNormal];
        
        // 计算X和Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - kScreenH;
        
        // 按钮出现时的动画
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        animation.springBounciness = 10; // 弹簧弹力
        animation.springSpeed = 10; // 弹簧速度
        animation.beginTime = CACurrentMediaTime() + 0.1 * i;
        [button pop_addAnimation:animation forKey:nil];
        
        // 添加标语
        UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"publishTitle"]];
        [self.view addSubview:sloganView];
        
        // 标语动画
        POPSpringAnimation *sloganAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerX = kScreenW * 0.5;
        CGFloat centerEndY = kScreenH * 0.2;
        CGFloat centerBeginY = centerEndY - kScreenH;
        sloganView.centerY = centerBeginY;
        sloganView.centerX = centerX;
        sloganAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
        sloganAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
        sloganAnimation.beginTime = CACurrentMediaTime() + titlesArray.count * 0.1;
        sloganAnimation.springBounciness = 10;
        sloganAnimation.springSpeed = 10;
        [sloganAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
            // 标语动画执行完毕，恢复点击事件
            self.view.userInteractionEnabled = YES;
        }];
        [sloganView pop_addAnimation:sloganAnimation forKey:nil];
        
    }
    
}

#pragma mark -- 退出当前控制器页面 --
- (IBAction)cancelAction:(UIButton *)sender {
    [self cancelWithCompletionBlock:nil];
}

#pragma mark -- 动画形式退出当前控制器页面 --
- (void)cancelWithCompletionBlock:(void (^)())completionBlock {
    // 让控制器的view不能被点击
    self.view.userInteractionEnabled = NO;
    int beginIndex = 2;
    for (int i = beginIndex; i < self.view.subviews.count; i++) {
        UIView *subview = self.view.subviews[i];
        // 基本动画
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + kScreenH;
       
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        animation.beginTime = CACurrentMediaTime() + (i - beginIndex) * 0.1;
        [subview pop_addAnimation:animation forKey:nil];
        
        // 监听最后一个动画
        if (i == self.view.subviews.count - 1) {
            [animation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                // 执行传进来的completionBlock参数
                !completionBlock ? : completionBlock();
            }];
        }
    }
}

#pragma mark -- 发帖 --
- (void)buttonClick:(UIButton *)button {
    
    PublishEditViewController *publishEditVC = [PublishEditViewController new];
    // 将button的title传递给publishEditVC
    publishEditVC.topicTitle = button.titleLabel.text;
    publishEditVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    UINavigationController *NC = [[UINavigationController alloc] initWithRootViewController:publishEditVC];
    [self presentViewController:NC animated:YES completion:nil];


    
    
//    [self cancelWithCompletionBlock:^{
//        if (button.tag == 2) {
//            // 判断是否登录
//            if ([XMGLoginTool getUid:YES] == nil) return;
//            
//            XMGPostWordViewController *postWord = [[XMGPostWordViewController alloc] init];
//            XMGNavigationController *nav = [[XMGNavigationController alloc] initWithRootViewController:postWord];
//            
//            // 这里不能使用self来弹出其他控制器, 因为self执行了dismiss操作
//            UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
//            [root presentViewController:nav animated:YES completion:nil];
//        }
//    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 pop和Core Animation的区别
 1.Core Animation的动画只能添加到layer上
 2.pop的动画能添加到任何对象
 3.pop的底层并非基于Core Animation, 是基于CADisplayLink
 4.Core Animation的动画仅仅是表象, 并不会真正修改对象的frame\size等值
 5.pop的动画实时修改对象的属性, 真正地修改了对象的属性
 */

@end
