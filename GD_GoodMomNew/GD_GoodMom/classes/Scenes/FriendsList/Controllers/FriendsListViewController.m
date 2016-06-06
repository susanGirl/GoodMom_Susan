//
//  FriendsListViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/23.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "FriendsListViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "TopicViewController.h"


// 帖子分类标签位置和尺寸
#define kTitlesViewH 35
#define kTitlesViewY 64

@interface FriendsListViewController ()<UIScrollViewDelegate> // 遵循协议
// 帖子分类标签视图
@property (strong, nonatomic) UIView *titleView;
// 帖子分类标签红色指示器
@property (strong, nonatomic) UIView *indicatorView;
// 帖子分类标签
@property (strong, nonatomic) UIButton *titleButton;
// 被选中的帖子分类标签
@property (strong, nonatomic) UIButton *selectedTitleButton;
// 内容视图
@property (strong, nonatomic) UIScrollView *topicContentView;
@end

@implementation FriendsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置导航栏
    [self setupNavigation];
    // 设置帖子分类标签视图
    [self setupTopicTitle];
    // 设置帖子分类的子控制器
    [self setupChildViewControllers];
    // 设置显示帖子内容的scrollView
    [self setupContentView];
    
}

#pragma mark -- 设置导航栏 --
- (void)setupNavigation {
    // 导航栏标题
    self.navigationItem.title = @"帖子";
    self.view.backgroundColor = kGlobalBackgroudColor;
}
#pragma mark -- 设置帖子分类标签 --
- (void)setupTopicTitle {
    // 创建标签
    self.titleView = [[UIView alloc] init];
    self.titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    // 位置和大小
    self.titleView.width = self.view.width;
    self.titleView.height = kTitlesViewH;
    self.titleView.y = kTitlesViewY;
    // 添加到父视图
    [self.view addSubview:self.titleView];
    
    
    // 创建帖子分类标签的红色指示器
    self.indicatorView = [[UIView alloc] init];
    self.indicatorView.backgroundColor = [UIColor magentaColor];
    self.indicatorView.height = 2;
    self.indicatorView.y = self.titleView.height - self.indicatorView.height;
    
    // 创建帖子分类标签
    NSArray *titlesArray = @[@"孕育", @"情感", @"生活", @"时尚"];
    CGFloat width = self.titleView.width / titlesArray.count;
    CGFloat height = self.titleView.height;
    for (NSInteger i = 0; i < titlesArray.count; i++) {
        self.titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.titleButton.tag = i;
        self.titleButton.width = width;
        self.titleButton.height = height;
        self.titleButton.x = i * width;
        [self.titleButton setTitle:titlesArray[i] forState:UIControlStateNormal];
        [self.titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.titleButton setTitleColor:[UIColor magentaColor] forState:UIControlStateDisabled];
        self.titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 添加到父视图
        [self.titleView addSubview:self.titleButton];
        
        // 设置默认选中的标签
        if (i == 0) {
            // 设置按钮为选中状态
            self.titleButton.enabled = NO;
            // 存储当前选中的按钮
            self.selectedTitleButton = self.titleButton;
            // 计算文字宽度，设置标签指示器的宽度。
            self.indicatorView.width = [titlesArray[i] sizeWithAttributes:@{NSFontAttributeName:self.titleButton.titleLabel.font}].width;
            // 设置标签指示器的位置
            self.indicatorView.centerX = self.titleButton.centerX;
        }
                            
    }
    
    // 将分类标签指示器最后添加到父视图，不影响分类标签在父视图数组中的位置。
    [self.titleView addSubview:self.indicatorView];
    
}

#pragma mark -- 切换分类标签的红色指示器 --
- (void)titleButtonClick:(UIButton *)button {
    // 设置选中按钮为未选中状态
    self.selectedTitleButton.enabled = YES;
    // 设置当前点击的按钮为选中状态
    button.enabled = NO;
    // 将当前点击的按钮保存为选中按钮
    self.selectedTitleButton = button;
    
    // 改变分类标签的红色指示器(动画效果，完成时间0.25s）
    [UIView animateWithDuration:0.25 animations:^{
        // 设置指示器宽度
        self.indicatorView.width = button.titleLabel.width;
        // 设置指示器位置
        self.indicatorView.centerX = button.centerX;
    }];
    
    // 内容视图contentView滚动
      // 获取内容视图偏移坐标属性
    CGPoint offset = self.topicContentView.contentOffset;
      // 内容视图的x方向偏移量（根据点击的button改变）
    offset.x = button.tag * self.topicContentView.width;
      // 重写设置内容视图的偏移坐标
    [self.topicContentView setContentOffset:offset animated:YES];
}

#pragma mark -- scrollView显示帖子内容的contentView --
- (void)setupContentView {
    
    self.topicContentView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    // 取消自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 显示内容区域，宽度等于所有子控制器的数量乘以子控制器的宽度
    self.topicContentView.contentSize = CGSizeMake(self.childViewControllers.count * self.topicContentView.width, 0);
    // 设置代理
    self.topicContentView.delegate = self;
    // 添加到父视图
    [self.view insertSubview:self.topicContentView atIndex:0];
    // 设置翻页效果
    self.topicContentView.pagingEnabled = YES;
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:self.topicContentView];
}

#pragma mark -- <UIScrollViewDelegate> --
// 结束滚动
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 添加子控制器的view
      // 取出当前子控制器的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
      // 取出当前子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 50; // 注意：经过调试验证了，系统会默认设置y为20，因此这里需要调整y值
    vc.view.height = scrollView.height; // 注意：设置完y值以后，要记得重新设置高度
     // 添加到父视图
    [scrollView addSubview:vc.view];
}

// 滚动视图已经停止减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 保证拖动结束后内容视图被添加到父视图上
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 拖动scrollView 时，让标签跟随着改变
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleButtonClick:self.titleView.subviews[index]];
}

#pragma mark -- 创建帖子分类的子视图控制器 --
- (void)setupChildViewControllers {
    
    TopicViewController *breedVC = [TopicViewController new];
    breedVC.title = @"孕育";
    breedVC.type = TopicTypeBreed;
    breedVC.view.backgroundColor = kGlobalBackgroudColor;
    [self addChildViewController:breedVC];
    
    TopicViewController *emotionVC = [TopicViewController new];
    emotionVC.title = @"情感";
    emotionVC.type = TopicTypeEmotion;
    emotionVC.view.backgroundColor = kGlobalBackgroudColor;
    [self addChildViewController:emotionVC];
    
    TopicViewController *lifeVC = [TopicViewController new];
    lifeVC.title = @"生活";
    lifeVC.type = TopicTypeLife;
    lifeVC.view.backgroundColor = kGlobalBackgroudColor;
    [self addChildViewController:lifeVC];
    
    TopicViewController *fashionVC = [TopicViewController new];
    fashionVC.title = @"时尚";
    fashionVC.type = TopicTypeFashion;
    fashionVC.view.backgroundColor = kGlobalBackgroudColor;
    [self addChildViewController:fashionVC];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
