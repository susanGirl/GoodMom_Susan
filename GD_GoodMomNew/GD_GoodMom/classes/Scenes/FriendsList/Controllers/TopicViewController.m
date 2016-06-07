//
//  TopicViewController.m
//  GD_GoodMom
//
//  Created by 80time on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "TopicViewController.h"
#import "TopicCell.h"
#import "Topic.h"
#import <AVOSCloud/AVOSCloud.h>
#import <MJRefresh.h>
#import "MBProgressHUD+gifHUD.h"
#import "TopicCommentViewController.h"


@interface TopicViewController ()

// 存放所有topic的数组
@property (strong, nonatomic) NSMutableArray *topicsArray;
// cell高度
@property (assign, nonatomic) CGFloat cellHeight;

@end

// topicCell的重用标识符
static NSString *const topicCellID = @"topicCell";
@implementation TopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化表格
    [self setupTableView];

    // 下拉刷新
    [self setupRefresh];

}

#pragma mark -- 初始化表格 --
- (void)setupTableView {
    
    // 减掉遮挡内容显示全部在scrollView上的信息
    CGFloat topOffset = 45; // 显示内容区域距离屏幕顶部偏移量
    CGFloat bottomOffset = self.tabBarController.tabBar.height; // 显示内容区域距离屏幕底部偏移量
    self.tableView.contentInset = UIEdgeInsetsMake(topOffset, 0, bottomOffset, 0);
    // 设置滚动条内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    // 取消系统自带的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 背景色
    self.tableView.backgroundColor = kGlobalBackgroudColor;
    
    // 注册topicCell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TopicCell class]) bundle:nil] forCellReuseIdentifier:topicCellID];
}

#pragma mark -- 下拉刷新、上拉加载 --
- (void)setupRefresh {
    
    // 下拉刷新
    // 下拉后，开始网络请求
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestTopics)];
    // 改变下拉控件的透明度（根据拖拽比例切换透明度）
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 开始刷新
    [self.tableView.mj_header beginRefreshing];
    
}

#pragma mark -- 初始化存放帖子的数组 --
- (NSArray *)topicsArray {
    if (!_topicsArray) {
        _topicsArray = [NSMutableArray array];
    }
    return _topicsArray;
}

#pragma mark -- 网络请求帖子数据 --
- (void)requestTopics {
    
    // 重新请求是移除数组内的之前的数据
    [self.topicsArray removeAllObjects];
    
    // 显示缓冲进度条
    [MBProgressHUD setupHUDWithFrame:CGRectMake(0, 0, 90, 80) gifName:@"pika" andShowToView:self.tableView];
    
    __weak TopicViewController *weakTopicVC = self;
    
    // 查询“Topic"表中不同类型的帖子
    AVQuery *queryTopic = [AVQuery queryWithClassName:@"Topic"];
    // 按照帖子发布时间排序(降序），让最新发布的帖子排在上面
    [queryTopic orderByDescending:@"createdAt"];
    // 根据帖子类型去查询该类型下的帖子
    [queryTopic whereKey:@"type" equalTo:self.title];
    [queryTopic findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        // 查询结果，服务器默认最多返回100条符合条件的结果，可以更改。
        for (AVObject *avObj in objects) {

            Topic *topic = [Topic new];
            [topic setValuesForKeysWithDictionary:[avObj objectForKey:@"localData"]];
            [topic setValue:avObj.createdAt forKey:@"creatAt"]; // 发帖时间
            [self.topicsArray addObject:topic];
        }
        // 回到主线程，刷新列表
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakTopicVC reloadAllData];
        });
    }];
}

#pragma mark -- 刷新数据 --
- (void)reloadAllData {
    [self.tableView reloadData];
    // 停止下拉刷新
    [self.tableView.mj_header endRefreshing];
    // 隐藏缓冲进度条
    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.topicsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicCellID forIndexPath:indexPath];
    
    cell.topic = self.topicsArray[indexPath.row];
    self.cellHeight = [cell calculateCellHeight];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return self.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TopicCommentViewController *topicCommentVC = [TopicCommentViewController new];
    topicCommentVC.topic = self.topicsArray[indexPath.row];
    // 将cell的高度传递给下个页面
    topicCommentVC.cellHeight = self.cellHeight;
    // 点击cell时，跳转到评论页面
    [self.navigationController pushViewController:topicCommentVC animated:YES];
}


@end
