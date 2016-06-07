//
//  GoodFoodViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "GoodFoodViewController.h"
#import "NetWorking.h"
#import <MJRefresh.h>
#import "WebViewController.h"
#import "PlayerViewController.h"
#import "Lists.h"
#import "VideoListsCell.h"



#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#import "CustomCell.h"

@interface GoodFoodViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UIScrollView *imagesScrollView;

@property(strong,nonatomic) UIPageControl *pageControl;
@property(strong,nonatomic)NSMutableArray  *imagesArray;// 图片数组
@property(strong,nonatomic)NSString  *post_Url;
@property(strong,nonatomic)NSString  *post_Body;
@property(strong,nonatomic)NSTimer  *timer;// 计时器
@property(assign,nonatomic)NSInteger  count;
@property(assign,nonatomic)NSInteger  number;

@property(strong,nonatomic)UITableView  *tableView;
@property(strong,nonatomic)UIView  *headerView;


@property(strong,nonatomic)NSMutableArray  *listsArray;
@end

static NSString * const customCellID = @"customCellReuseIdentifier";
static NSString * const videoCellID = @"videoListCellIdentifier";
@implementation GoodFoodViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-self.tabBarController.tabBar.frame.size.height*3) style:UITableViewStylePlain];
    _tableView.separatorColor = [UIColor redColor];
    // 设置代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 注册cell
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:customCellID];
    [_tableView registerNib:[UINib nibWithNibName:@"VideoListsCell" bundle:nil] forCellReuseIdentifier:videoCellID];
    // 添加到视图上
    [self.view addSubview:self.tableView];
    
    // 开辟空间请求数据
    _listsArray = [NSMutableArray array];
    [self netWorkingAndSetUp];
    
//    [self netWorkingWithTableView];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    // 下拉刷新
    [self setupRefresh];
}
#pragma mark -- 下拉刷新、上拉加载 --
- (void)setupRefresh {
    
    // 下拉刷新
    // 下拉后，开始网络请求
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netWorkingAndSetUp)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netWorkingWithTableView)];
    // 改变下拉控件的透明度（根据拖拽比例切换透明度）
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 开始刷新
    [self.tableView.mj_header beginRefreshing];
    
}
#pragma mark -- 刷新数据 --
- (void)reloadAllData {
    [self.tableView reloadData];
    // 停止下拉刷新
    [self.tableView.mj_header endRefreshing];
    // 隐藏缓冲进度条
//    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
}
#pragma mark --美食
#pragma mark --轮播图
// 解析数据并画图赋值
- (void)netWorkingAndSetUp{
    
    _imagesScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*5/8)];
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, kScreenW*5/8+130)];
    _tableView.tableHeaderView = _headerView;
    [self.headerView addSubview:_imagesScrollView];
    [self setUp];
    self.post_Url = @"http://api.miyabaobei.com/channel/banner/";
    self.post_Body = @"sign=d4d2d33882f014c6c46bf52f179c0da5&dvc_id=7b1d8112322eac6a647266388accce6c&session=868047022239927&android_mac=40%3Ac6%3A2a%3A3d%3A8e%3Ae8&channel_code=qq&version=android_4_1_1&bi_session_id=7b1d8112322eac6a647266388accce6c_1464610598311&app_id=android_app_id&timestamp=1464610624&device_token=3HnQZa6MCPr4BNhGwtMf2ie9N8AvCyrSFLawTixLB%2FA%3D&regid=3HnQZa6MCPr4BNhGwtMf2ie9N8AvCyrSFLawTixLB%2FA%3D&auth_session=&params=A85f788qNyTuy_INo-NBkhN50TBpcy_j1sZN_CYyYCYz0mlC4RzOq2ehXdO1Iokq4XCZ_pd20c98kQnxVUeMH-GnITjYIBs6bXg5RNdbgep0XMLqkxDMOQ7ntW40Z1Tvod3bYpSpvaOLGsJmfxWp8mb1-2hh6d9Tw7E4OicUZaA%3D&";
    __weak GoodFoodViewController *googVC = self;
    [NetWorking netWorkingPostActionWithURLString:self.post_Url bodyURLString:self.post_Body completeHandle:^(NSData * _Nullable data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *banner in dict[@"content"][@"banner"]) {
            [tempArray addObject:banner];
        }
        self.imagesArray = [NSMutableArray array];
        for (int i = 0; i < tempArray.count; i++) {
            
            NSString *imgUrlString = tempArray[i][@"image"];
            [self.imagesArray addObject:imgUrlString];
        }
//        NSLog(@"❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️-->解析");
        _count = self.imagesArray.count;
//        NSLog(@"%ld",_count);
        [self drawView];
        // 回到主线程，刷新列表
        dispatch_async(dispatch_get_main_queue(), ^{
            [googVC reloadAllData];
        });
    }];
    
    
}
- (void)drawView{
    
    
    // 设置显示内容区域大小
    
    self.imagesScrollView.contentSize = CGSizeMake(kScreenWidth*self.imagesArray.count, self.imagesScrollView.frame.size.height);
    
    _imagesScrollView.delegate =self;
    for (int i = 0; i < _count; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*i, CGRectGetMinY(self.imagesScrollView.frame), kScreenWidth, CGRectGetMaxY(self.imagesScrollView.frame))];
        [imgView sd_setImageWithURL:[NSURL URLWithString:self.imagesArray[i]]];
        
        [self.imagesScrollView addSubview:imgView];
    }
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, self.imagesArray.count * 15, 50)];
    _pageControl.center = CGPointMake(self.view.center.x, CGRectGetMaxY(_imagesScrollView.frame)-25);
    _pageControl.numberOfPages = self.imagesArray.count;
    // 选中的颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:241/255.0 green:158/255.0 blue:194/255.0 alpha:1];
    // 未选中的颜色
    _pageControl.pageIndicatorTintColor = [UIColor redColor];
    [self.view addSubview:_pageControl];
    [_pageControl addTarget:self action:@selector(pageControlAction:) forControlEvents:UIControlEventValueChanged];
}
- (void)timerAction{
    _number = self.pageControl.currentPage;
    _number++;
    if (_number == self.imagesArray.count) {
        _number = 0;
    }
    self.pageControl.currentPage = _number;
    [self.imagesScrollView setContentOffset:CGPointMake(self.pageControl.currentPage*kScreenWidth, 0) animated:YES];
    
}
- (void)pageControlAction:(UIPageControl *)pageControl{
    
    self.imagesScrollView.contentOffset = CGPointMake(pageControl.currentPage * kScreenWidth,0);
    
}
#pragma mark --CollectionView
- (void)setUp{
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    // 设置每个item的大小
    flowLayout.itemSize = CGSizeMake((kScreenWidth-80)/3, 50);
    // 设置单个分区距离上下左右的位置
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, (kScreenWidth*5/8), kScreenWidth, 130) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView setTag:101];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    // 注册自定义cell
    [collectionView registerClass:[CustomCell class] forCellWithReuseIdentifier:customCellID];
    [self.headerView addSubview:collectionView];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:customCellID forIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.imgView.image = [UIImage imageNamed:@"冷冲饮品"];
        }else if (indexPath.row == 1){
            
            cell.imgView.image = [UIImage imageNamed:@"休闲零食"];
        }else{
            
            cell.imgView.image = [UIImage imageNamed:@"功效指南"];
        }
    }else{
        if (indexPath.row == 0) {
            cell.imgView.image = [UIImage imageNamed:@"女神专区"];
        }else if (indexPath.row == 1){
            
            cell.imgView.image = [UIImage imageNamed:@"男神专区"];
        }else{
            
            cell.imgView.image = [UIImage imageNamed:@"长辈专区"];
        }
    }
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self pushWebView:@"冷冲饮品" url:@"http://www.mia.com/search/s?k=%E5%86%B2%E8%B0%83%2F%E9%A5%AE%E5%93%81"];
        }else if (indexPath.row == 1){
            
            [self pushWebView:@"休闲零食" url:@"http://www.mia.com/search/s?k=%E4%BC%91%E9%97%B2%E9%9B%B6%E9%A3%9F"];
        }else{
            
            [self pushWebView:@"功效指南" url:@"http://www.mia.com/search/s?k=%E5%8A%9F%E6%95%88%E8%90%A5%E5%85%BB%E4%B8%93%E5%8C%BA"];
        }
    }else{
        if (indexPath.row == 0) {
            [self pushWebView:@"女神专区" url:@"http://www.mia.com/search/s?k=%E5%A5%B3%E6%80%A7%E8%90%A5%E5%85%BB%E9%A3%9F%E5%93%81"];
        }else if (indexPath.row == 1){
            
            [self pushWebView:@"男神专区" url:@"http://www.mia.com/search/s?k=%E7%94%B7%E6%80%A7%E8%90%A5%E5%85%BB%E9%A3%9F%E5%93%81"];
        }else{
            
            [self pushWebView:@"长辈专区" url:@"http://www.mia.com/search/s?k=%E8%80%81%E5%B9%B4%E4%BA%BA%E8%90%A5%E5%85%BB%E4%B8%93%E5%8C%BA"];
        }
    }
}
- (void)pushWebView:(NSString *)title url:(NSString *)url {
    
    WebViewController *webViewVC = [WebViewController new];
    
    webViewVC.webView.scalesPageToFit = YES;// 是否自适应
    
    webViewVC.webViewUrl = url;
    webViewVC.name = title;
    [self.navigationController pushViewController:webViewVC animated:YES];
}
#pragma mark --tableView
- (void)netWorkingWithTableView{
    NSString *post_videoUrl = @"http://m.douguo.com/video/ajaxshowlist";
    NSString *post_videoBody_1 = @"type=baobaocai&offset=0&limit=10";
    [self netWorkWithVideoUrl:post_videoUrl body:post_videoBody_1];
    NSString *post_videoBody_2 = @"type=baobaocai&offset=20&limit=10";
    [self netWorkWithVideoUrl:post_videoUrl body:post_videoBody_2];
    NSString *post_videoBody_3 = @"type=baobaocai&offset=30&limit=10";
    [self netWorkWithVideoUrl:post_videoUrl body:post_videoBody_3];
    NSString *post_videoBody_4 = @"type=baobaocai&offset=40&limit=10";
    [self netWorkWithVideoUrl:post_videoUrl body:post_videoBody_4];
    NSString *post_videoBody_5 = @"type=baobaocai&offset=50&limit=10";
    [self netWorkWithVideoUrl:post_videoUrl body:post_videoBody_5];
}
- (void)netWorkWithVideoUrl:(NSString *)url body:(NSString *)body{

    __weak GoodFoodViewController *goodVC = self;
    [NetWorking netWorkingPostActionWithURLString:url bodyURLString:body completeHandle:^(NSData * _Nullable data) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        for (NSDictionary *listDic in dict[@"data"][@"lists"]) {
            //            NSLog(@"电影播放列表：-》%@",listDic);
            Lists *list = [Lists new];
            [list setValuesForKeysWithDictionary:listDic];
            [_listsArray addObject:list];
//            NSLog(@"电影播放列表：-》%@",list.video_url);
#pragma mark ----------TODO----------
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // 回到主线程-->切记刷新-->刷新UI
            [goodVC reloadAllData];
        });
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _listsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoListsCell * cell = [tableView dequeueReusableCellWithIdentifier:videoCellID];
        Lists *list = [Lists new];
        list = _listsArray[indexPath.row];
        cell.list = list;
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 388;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Lists *list = [Lists new];
    
    list = _listsArray[indexPath.row];
    
    BOOL b = [list.video_url hasPrefix:@"http"];
    
    if (b == YES ) {
//        [self pushWebView:list.name url:list.video_url];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:list.video_url]];
    }else{
        PlayerViewController  *videoVC = [PlayerViewController new];
        videoVC.ID = list.ID;
        videoVC.name = list.name;
        NSLog(@"%@",videoVC.ID);
        [self.navigationController pushViewController:videoVC animated:YES];
    }
}

@end
