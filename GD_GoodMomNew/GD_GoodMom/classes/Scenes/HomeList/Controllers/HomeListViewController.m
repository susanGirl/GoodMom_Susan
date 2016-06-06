//
//  HomeListViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/23.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "HomeListViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "UIView+Extension.h"
@interface HomeListViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *titleView;//顶部标签UIScrollView

@property(nonatomic,strong)UIView *indicatiorView;//指示器
@property(nonatomic,strong)UIButton *selectedBUtton;//当前选中的按钮
@property(nonatomic,strong)UIScrollView *contenView;//底部内容
@end

@implementation HomeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:COLOR_arc green:COLOR_arc blue:COLOR_arc alpha:1.0];

    
    //初始化所有子控制器
    [self setupChildViewControllers];
    
    //设置标题栏
    [self setUpTitleView];

    //设置内容
    [self setUpContentView];
    


}
-(void)setUpTitleView{
    UIScrollView *titleView = [[UIScrollView alloc]init];
    titleView.backgroundColor= [UIColor grayColor];
    titleView.frame = CGRectMake(0, 64, self.view.bounds.size.width, 36);
    titleView.contentSize = CGSizeMake(450, 0);
    titleView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:titleView];
    self.titleView = titleView;
    //底部的红色指示器
    UIView *indicatiorView = [[UIView alloc]init];
    indicatiorView.backgroundColor = [UIColor redColor];
    indicatiorView.height = 2;
    indicatiorView.y = titleView.height - indicatiorView.height;
    indicatiorView.tag = - 1;
    self.indicatiorView = indicatiorView;
    //内部的子标签
    NSArray *titles = @[@"首页",@"孕婴",@"童装",@"玩具",@"美妆",@"美食",@"家居",@"童书"];
    CGFloat width = 50;
    CGFloat height = titleView.frame.size.height;
    for (int i= 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake(i * width, 0, width, height);
        button.tag = i;
        [button setTitle:titles[i] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor redColor] forState:(UIControlStateDisabled)];
        button.titleLabel.font = [UIFont systemFontOfSize:14];

        [button addTarget:self action:@selector(titleClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [titleView addSubview:button];
        
        
        //默认点击第一个按钮
        if (i == 0) {
            
            button.enabled = NO;
            self.selectedBUtton = button;
            //让按钮内部的label根据文字的内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatiorView.width = button.titleLabel.width;
            self.indicatiorView.centerX = button.centerX;
            
        }
        
    }
    [titleView addSubview:indicatiorView];
    

}

-(void)titleClick:(UIButton *)button{

    //修改按钮状态
    self.selectedBUtton.enabled =  YES;
    button.enabled =NO;
    self.selectedBUtton = button;
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        
        self.indicatiorView.width = button.titleLabel.width;
        self.indicatiorView.centerX  = button.centerX;
    
    }];
    //滚动
 
    CGPoint offset = self.contenView.contentOffset;
    offset.x = button.tag * self.contenView.width;
    [self.contenView setContentOffset:offset animated:YES];
    
    
    
}
//设置内容UIScrollView
-(void)setUpContentView{
    UIScrollView *contentScrollView  = [[UIScrollView alloc]init];
    contentScrollView.frame = self.view.bounds;
    contentScrollView.delegate = self;
    contentScrollView.pagingEnabled = YES;
    [self.view insertSubview:contentScrollView atIndex:0];
    self.contenView = contentScrollView;
    

  }
#pragma mark----UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{


    //当前索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;//设置控制器view的y值为0
    vc.view.height = scrollView.height;//设置控制器view的y值为0
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(self.titleView.frame);
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条的内边距
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    [scrollView addSubview:vc.view];
    

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    [self scrollViewDidEndScrollingAnimation:scrollView];
    //点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titleView.subviews[index]];

}
-(void)setupChildViewControllers{

    

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
