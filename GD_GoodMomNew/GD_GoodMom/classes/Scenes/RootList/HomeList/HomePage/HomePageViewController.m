//
//  HomePageViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "HomePageViewController.h"

#import "NetWorking.h"
#import <MJRefresh.h>
#import "HomePageCell_1.h"
#import "HomePageCell_2.h"
#import "HomePageCell_3.h"


#define POST_URL @"http://api.miyabaobei.com/banner/listsExt/"
#define POST_BODY @"sign=1b0e42f8090bc2b73d7b69454ffde1d2&dvc_id=7b1d8112322eac6a647266388accce6c&session=868047022239927&android_mac=40%3Ac6%3A2a%3A3d%3A8e%3Ae8&channel_code=qq&version=android_4_1_1&bi_session_id=7b1d8112322eac6a647266388accce6c_1464053774068&app_id=android_app_id&timestamp=1464054235&device_token=3HnQZa6MCPr4BNhGwtMf2ie9N8AvCyrSFLawTixLB%2FA%3D&regid=3HnQZa6MCPr4BNhGwtMf2ie9N8AvCyrSFLawTixLB%2FA%3D&auth_session=&params=FZ4Q5tsdK0T69aikOKMILPl9ykWVDwoWSuYrkV3UEQrp9ndN2dJ3R8dO22eopxzswrCGeGZjjKbiOKzAnXUfAQsMewVcr8SD6r2jMZ2MH3rQZMlAVMhdI4j-4i1z1gpAbH9yfM5qqZkWDgp4nnObPDR4uLK64JTvYGE4ENFq6N8%3D&"
//#define POST_Cell_URL @"http://api.miyabaobei.com/index/template/"
//#define POST_Cell_BODY @"sign=0d6f8a675c36ad51a1dc16365e989164&dvc_id=7b1d8112322eac6a647266388accce6c&session=868047022239927&android_mac=40%3Ac6%3A2a%3A3d%3A8e%3Ae8&channel_code=qq&version=android_4_1_1&bi_session_id=7b1d8112322eac6a647266388accce6c_1464226049529&app_id=android_app_id&timestamp=1464226128&device_token=3HnQZa6MCPr4BNhGwtMf2ie9N8AvCyrSFLawTixLB%2FA%3D&regid=3HnQZa6MCPr4BNhGwtMf2ie9N8AvCyrSFLawTixLB%2FA%3D&auth_session=&"

@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>



@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) UIScrollView *imagesScrollView;
#pragma mark --轮播图属性--
@property(strong,nonatomic) UIPageControl *pageControl;
@property(strong,nonatomic)NSMutableArray  *imagesArray;// 图片数组
@property(strong,nonatomic)NSTimer  *timer;// 计时器
@property(assign,nonatomic)NSInteger  count;
@property(strong,nonatomic)UICollectionView  *collectionView;
/*
@property(strong,nonatomic)NSMutableArray  *listArray;// 数据总列表section个数的数组
@property(strong,nonatomic)NSMutableArray  *modulesArray;// 每列数据中row个数的数组
@property(strong,nonatomic)NSMutableArray  *dataArray;// 每个row中的图片个数的数组
@property(strong,nonatomic)NSMutableArray  *picArray;
@property(strong,nonatomic)NSMutableArray  *typeArray;

@property(strong,nonatomic)NSMutableArray  *outlets_infosArray;
@property(strong,nonatomic)NSMutableArray  *outlet_itemsArray;
@property(strong,nonatomic)NSMutableArray  *image_indexArray;
@property(strong,nonatomic)NSMutableDictionary  *dict;
*/
@property (weak, nonatomic) IBOutlet UITableView *hometPageTableView;

@end



/*
static NSString * const cellType_1 = @"cellType_1_identifier";
static NSString * const cellType_2 = @"cellType_2_identifier";
static NSString * const cellType_3 = @"cellType_3_identifier";
static NSString * const cellType_4 = @"cellType_4_identifier";
static NSString * const cellType_7 = @"cellType_7_identifier";
*/

static NSString * const homePageCell_1_ID = @"HomePageCell_1_identifier";
static NSString * const homePageCell_2_ID = @"HomePageCell_2_identifier";
static NSString * const homePageCell_3_ID = @"HomePageCell_3_identifier";
@implementation HomePageViewController

/*
- (void)viewWillAppear:(BOOL)animated{

    _listArray = [NSMutableArray array];
    _modulesArray = [NSMutableArray array];
    _dataArray = [NSMutableArray array];
    _picArray = [NSMutableArray array];
    _typeArray = [NSMutableArray array];
    _outlets_infosArray = [NSMutableArray array];
    _outlet_itemsArray = [NSMutableArray array];
    _image_indexArray = [NSMutableArray array];
    _dict = [NSMutableDictionary dictionary];
}
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:COLOR_arc green:COLOR_arc blue:COLOR_arc alpha:1.0];
    _imagesScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW*5/8)];
    [self netWorkingAndSetUp];
    // 设置头部视图
    _hometPageTableView.tableHeaderView = _imagesScrollView;
    // 注册
    [_hometPageTableView registerNib:[UINib nibWithNibName:@"HomePageCell_1" bundle:nil] forCellReuseIdentifier:homePageCell_1_ID];
    [_hometPageTableView registerNib:[UINib nibWithNibName:@"HomePageCell_2" bundle:nil] forCellReuseIdentifier:homePageCell_2_ID];
    [_hometPageTableView registerNib:[UINib nibWithNibName:@"HomePageCell_3" bundle:nil] forCellReuseIdentifier:homePageCell_3_ID];
    /*
    // 注册CellType_1
    [_hometPageTableView registerNib:[UINib nibWithNibName:@"CellType_1" bundle:nil] forCellReuseIdentifier:cellType_1];
    [_hometPageTableView registerNib:[UINib nibWithNibName:@"CellType_2" bundle:nil] forCellReuseIdentifier:cellType_2];
    [_hometPageTableView registerNib:[UINib nibWithNibName:@"CellType_3" bundle:nil] forCellReuseIdentifier:cellType_3];
    [_hometPageTableView registerNib:[UINib nibWithNibName:@"CellType_4" bundle:nil] forCellReuseIdentifier:cellType_4];
    [_hometPageTableView registerNib:[UINib nibWithNibName:@"CellType_7" bundle:nil] forCellReuseIdentifier:cellType_7];
     */
    // 设置代理
    self.hometPageTableView.delegate = self;
    self.hometPageTableView.dataSource = self;


    self.timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    // 下拉刷新
    [self setupRefresh];
}
#pragma mark -- 下拉刷新、上拉加载 --

- (void)setupRefresh {
    
    // 下拉刷新
    // 下拉后，开始网络请求
    self.hometPageTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netWorkingAndSetUp)];
    // 改变下拉控件的透明度（根据拖拽比例切换透明度）
    self.hometPageTableView.mj_header.automaticallyChangeAlpha = YES;
    // 开始刷新
    [self.hometPageTableView.mj_header beginRefreshing];
    
}
#pragma mark -- 刷新数据 --
- (void)reloadAllData {
    [self.hometPageTableView reloadData];
    // 停止下拉刷新
    [self.hometPageTableView.mj_header endRefreshing];
    // 隐藏缓冲进度条
//    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
}

#pragma mark -- 首页
// 解析数据
- (void)netWorkingAndSetUp{
    
    // 轮播图数据解析
    __weak HomePageViewController *homeVC = self;
    [NetWorking netWorkingPostActionWithURLString:POST_URL bodyURLString:POST_BODY completeHandle:^(NSData * _Nullable data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSArray *outletsArray in dict[@"content"][@"outlets"]) {
            
            [tempArray addObject:outletsArray];
        }
        
        self.imagesArray = [NSMutableArray array];
        for (int i = 0; i < tempArray.count; i++) {
            NSMutableDictionary *dict1 = [NSMutableDictionary dictionaryWithDictionary:tempArray[i][@"pic"]];
            NSString *imgUrlString = dict1[@"url"];
            [self.imagesArray addObject:imgUrlString];
        }
        _count = self.imagesArray.count;
        [self drawView];
        // 回到主线程，刷新列表
        dispatch_async(dispatch_get_main_queue(), ^{
            [homeVC reloadAllData];
        });
    }];
    
    // 解析Cell内容
    /*
    [NetWorking netWorkingPostActionWithURLString:POST_Cell_URL bodyURLString:POST_Cell_BODY completeHandle:^(NSData * _Nullable data) {

        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *listDic in dict[@"content"][@"list"]) {
            HomeModel *home = [HomeModel new];
            [home setValuesForKeysWithDictionary:listDic];
            [self.listArray addObject:home.modules];
            
        }
        
        // 回到主线程，刷新列表
        dispatch_async(dispatch_get_main_queue(), ^{
            [homeVC reloadAllData];
        });
        
    }];
    
    
#pragma mark--tableView下半部分
#define post_url  @"http://api.miyabaobei.com/index/index"
#define post_body   @"sign=e1180a328728b032ee51bad98b3c4480&dvc_id=7b1d8112322eac6a647266388accce6c&session=868047022239927&android_mac=40%3Ac6%3A2a%3A3d%3A8e%3Ae8&channel_code=qq&version=android_4_1_1&bi_session_id=7b1d8112322eac6a647266388accce6c_1464568837173&app_id=android_app_id&timestamp=1464568845&device_token=3HnQZa6MCPr4BNhGwtMf2ie9N8AvCyrSFLawTixLB%2FA%3D&regid=3HnQZa6MCPr4BNhGwtMf2ie9N8AvCyrSFLawTixLB%2FA%3D&auth_session=&params=AyWqdXGnTXw9Djle-H_4yeIeigGvEnEmc1s0Pbf9IcgnVwPDL0Prp-wUCzDYNgMmeFXkmx5Z_rih_wV9nHUNwq5aE7NTY0qw0qsPd2HWQ4V82XOhT-Fmw_lL5zLkDi08U2H00uJH0w6wRfwUcoPtJa6wL7vrsUZGuaw8hPDKdPo%3DatOBb-WoJo699EpA4pae0FM34AJE3imPOe-tZIOscLEngVEP-81STbqDMC0Vc0skRsCwK4leeQAjRtMC5k8lki030XsG_6CV8_xPwMc34gi6eU1LQvhznG2TzSv0nmgiL8YUdJkkLRQTKXCXdZejfPIGXiybrBLzABlmRBuIu7Y%3D&"
    [NetWorking netWorkingPostActionWithURLString:post_url bodyURLString:post_body completeHandle:^(NSData * _Nullable data) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.dict = dict.mutableCopy;
        //        NSLog(@"🔥🔥🔥%@🔥🔥🔥",dict); //通过！！！有数据
        for (NSDictionary *listDic in dict[@"content"][@"outlets_infos"]) {
            Outlets_infos *outlets_infos = [Outlets_infos new];
            [outlets_infos setValuesForKeysWithDictionary:listDic];
            
            [self.outlets_infosArray addObject:outlets_infos];
            
            
            [self.image_indexArray addObject:outlets_infos.image_index];
            
            [self.outlet_itemsArray addObject:outlets_infos.outlet_items];
            //            NSLog(@"%ld-💧💧💧->%@",_outlet_itemsArray.count,_outlet_itemsArray);
            
        }
        
        // 回到主线程，刷新列表
        dispatch_async(dispatch_get_main_queue(), ^{
            [homeVC reloadAllData];
        });
        
    }];
    */
    
}
#pragma mark--绘制轮播图--
- (void)drawView{
    
    // 设置显示内容区域大小
    self.imagesScrollView.contentSize = CGSizeMake(kScreenW*self.imagesArray.count, self.imagesScrollView.frame.size.height);
    self.imagesScrollView.pagingEnabled = YES;
    for (int i = 0; i < _count; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenW*i, 0, kScreenW, CGRectGetMaxY(self.imagesScrollView.frame))];
        [imgView sd_setImageWithURL:[NSURL URLWithString:self.imagesArray[i]]placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"%02d.jpg",i]]];
        
        [self.imagesScrollView addSubview:imgView];
    }
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, self.imagesArray.count * 15, 50)];
    _pageControl.center = CGPointMake(kScreenW/2, CGRectGetMaxY(_imagesScrollView.frame)-25);
    _pageControl.numberOfPages = self.imagesArray.count;
    // 选中的颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:241/255.0 green:158/255.0 blue:194/255.0 alpha:1];
    // 未选中的颜色
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
//    [self.hometPageTableView addSubview:_pageControl];
    
    [_pageControl addTarget:self action:@selector(pageControlAction:) forControlEvents:UIControlEventValueChanged];

}
NSInteger number;
- (void)timerAction{
    number = self.pageControl.currentPage;
    number++;
    if (number == self.imagesArray.count) {
        number = 0;
    }
    self.pageControl.currentPage = number;
    [self.imagesScrollView setContentOffset:CGPointMake(self.pageControl.currentPage*kScreenW, 0) animated:YES];
}
- (void)pageControlAction:(UIPageControl *)pageControl{
    
    self.imagesScrollView.contentOffset = CGPointMake(pageControl.currentPage * kScreenW,0);
    
}

    

#pragma mark --tableView布局--

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{


//    return self.listArray.count+self.outlets_infosArray.count;
    return 3;
}
// 每个分组row个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    /*
    NSMutableArray *modulesArray = [NSMutableArray array];
    NSMutableArray *typeArray = [NSMutableArray array];
    if (section < self.listArray.count) {
        for (NSDictionary *dic in self.listArray[section]) {
            Modoules *modules = [Modoules new];
            [modules setValuesForKeysWithDictionary:dic];
            [modulesArray addObject:modules.data];
            
            [typeArray addObject:modules.type];
//            NSLog(@"section%ld-%ld-type总类型个数是%ld-type型号是：%@",section,modulesArray.count,typeArray.count,typeArray);
        }
        _modulesArray = modulesArray;
        if (_modulesArray != modulesArray) {
            _modulesArray = nil;
            _modulesArray = modulesArray;
        }
        _typeArray = typeArray;
        if (_typeArray != typeArray) {
            _typeArray = nil;
            _typeArray = typeArray;
        }
        //    NSLog(@"section->%ld✨✨✨✨✨✨✨row->%ld",section,_modulesArray.count);
        return _modulesArray.count;
    }else{
        //        NSLog(@"-💧💧%ld💧->",section);
        return 2;
    }
    */
    if (section == 0) {
        return 1;
    }else if (section == 1){
    
        return 4;
    }
    return 3;
}
// 绘制tableViewcell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UITableViewCell *cell = [self index:indexPath tableView:tableView];
//    return cell;
    if (indexPath.section == 0) {
        HomePageCell_1 *cell = [_hometPageTableView dequeueReusableCellWithIdentifier:homePageCell_1_ID];
        return cell;
    }else if (indexPath.section == 1){
        HomePageCell_2 *cell = [_hometPageTableView dequeueReusableCellWithIdentifier:homePageCell_2_ID];
        cell.buttonVC = self;
        if (indexPath.row == 0) {
            cell.url_1 = @"http://www.mia.com/junsale/main";
            cell.url_2 = @"http://www.mia.com/junesale/juneRedbag";
            cell.name_1 = @"🎁礼物🎁";
            cell.name_2 = @"💰红包💰";
            return cell;
        }else if (indexPath.row == 1) {
            cell.url_1 = @"http://www.mia.com/special/module/index/5329/pc";
            cell.url_2 = @"http://www.mia.com/special/module/index/5027";
            cell.name_1 = @"童装👗童鞋👟";
            cell.name_2 = @"玩具⚽️童书📕";
            [cell.button_1 setBackgroundImage:[UIImage imageNamed:@"童装童鞋.jpg"] forState:UIControlStateNormal];
            [cell.button_2 setBackgroundImage:[UIImage imageNamed:@"玩具童书.jpg"] forState:UIControlStateNormal];
            return cell;
        }else if (indexPath.row == 2){
            cell.url_1 = @"http://www.mia.com/special/module/index/5021/pc";
            cell.url_2 = @"http://www.mia.com/special/module/index/5206/pc";
            cell.name_1 = @"全球纸尿裤🍙";
            cell.name_2 = @"全球好奶粉🍼";
            [cell.button_1 setBackgroundImage:[UIImage imageNamed:@"全球纸尿裤.jpg"] forState:UIControlStateNormal];
            [cell.button_2 setBackgroundImage:[UIImage imageNamed:@"全球好奶粉.jpg"] forState:UIControlStateNormal];
            return cell;
        }else{
            cell.url_1 = @"http://www.mia.com/special/module/index/4943/pc";
            cell.url_2 = @"http://www.mia.com/special/module/index/4930/pc";
            cell.name_1 = @"孕产母乳👪";
            cell.name_2 = @"美妆个护💄";
            [cell.button_1 setBackgroundImage:[UIImage imageNamed:@"孕产母乳.jpg"] forState:UIControlStateNormal];
            [cell.button_2 setBackgroundImage:[UIImage imageNamed:@"美妆个护.jpg"] forState:UIControlStateNormal];
            return cell;
        }
    }else{
        HomePageCell_3 *cell = [_hometPageTableView dequeueReusableCellWithIdentifier:homePageCell_3_ID];
        cell.buttonVC = self;
        if (indexPath.row == 0) {
            cell.url_1 = @"http://www.mia.com/special/module/index/4931/pc";
            cell.url_2 = @"http://www.mia.com/special/module/index/4974/pc";
            cell.url_3 = @"http://www.mia.com/special/module/index/5010/pc";
            cell.name_1 = @"儿童寝居🏡";
            cell.name_2 = @"宝宝洗护清洁🛁";
            cell.name_3 = @"喂养用品🍲";
            [cell.button_1 setBackgroundImage:[UIImage imageNamed:@"儿童寝居.jpg"] forState:UIControlStateNormal];
            [cell.button_2 setBackgroundImage:[UIImage imageNamed:@"宝宝洗护清洁.jpg"] forState:UIControlStateNormal];
            [cell.button_3 setBackgroundImage:[UIImage imageNamed:@"喂养用品.jpg"] forState:UIControlStateNormal];
            
            return cell;
        }else if (indexPath.row == 1){
            cell.url_1 = @"http://www.mia.com/special/module/index/4980/pc";
            cell.url_2 = @"http://www.mia.com/special/module/index/4897/pc";
            cell.url_3 = @"http://www.mia.com/special/module/index/4922/pc";
            cell.name_1 = @"辅食营养🍜";
            cell.name_2 = @"宝宝出行🚗";
            cell.name_3 = @"家居生活🏩";
            [cell.button_1 setBackgroundImage:[UIImage imageNamed:@"辅食营养.jpg"] forState:UIControlStateNormal];
            [cell.button_2 setBackgroundImage:[UIImage imageNamed:@"宝宝出行.jpg"] forState:UIControlStateNormal];
            [cell.button_3 setBackgroundImage:[UIImage imageNamed:@"家居生活.jpg"] forState:UIControlStateNormal];
            
            return cell;
        }else{
            cell.url_1 = @"http://www.mia.com/special/module/index/4851/pc";
            cell.url_2 = @"http://www.mia.com/special/module/index/4853/pc";
            cell.url_3 = @"http://www.mia.com/special/module/index/4942/pc";
            cell.name_1 = @"环球美食🍝";
            cell.name_2 = @"营养保健🍛";
            cell.name_3 = @"全球代购👜📲";
            [cell.button_1 setBackgroundImage:[UIImage imageNamed:@"环球美食.jpg"] forState:UIControlStateNormal];
            [cell.button_2 setBackgroundImage:[UIImage imageNamed:@"营养保健.jpg"] forState:UIControlStateNormal];
            [cell.button_3 setBackgroundImage:[UIImage imageNamed:@"全球代购.jpg"] forState:UIControlStateNormal];
            
            return cell;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 100;
    }else{
        return kScreenW/3;
    }
}
// 绘图cell时需要调用的私有方法。
/**
 *  绘图cell时需要调用的私有方法。
 *
 *  @param indexPath  下脚标
 *  @param cell       当前cell
 *  @param typeNumber cell类型编号
 *  @param imgView1   cell中的图片代号
 *  @param imgView2   cell中的图片代号
 *  @param imgView3   cell中的图片代号
 *  @param imgView4   cell中的图片代号
 *  @param imgView5   cell中的图片代号
 *  @param scrollView cell中的滚动视图代号
 *
 *  @return 当前cell样式
 */

//- (UITableViewCell *)index:(NSIndexPath *)indexPath tableView:(UITableView *)tableView{
    //==========
    /*
    if (indexPath.section < self.listArray.count) {
        // 1-①
        NSMutableArray *typeArray = [NSMutableArray array];
        NSMutableArray *modulesArray = [NSMutableArray array];
        for (NSDictionary *dic in self.listArray[indexPath.section]) {
            Modoules *modules = [Modoules new];
            [modules setValuesForKeysWithDictionary:dic];
            [modulesArray addObject:modules.data];
            [typeArray addObject:modules.type];
            //                        NSLog(@"=====✨✨✨data✨✨%@",modules.data);
        }
        
        // 1-②
        _modulesArray = modulesArray;
        if (_modulesArray != modulesArray) {
            _modulesArray = nil;
            _modulesArray = modulesArray;
        }
        _typeArray = typeArray;
        if (_typeArray != typeArray) {
            _typeArray = nil;
            _typeArray = typeArray;
        }
        
        // 1-③
        NSMutableArray *picArray = [NSMutableArray array];
        for (NSDictionary *dataDict in _modulesArray[indexPath.row]) {
            Data *data = [Data new];
            [data setValuesForKeysWithDictionary:dataDict];
            
            Pic *pic = [Pic new];
            [pic setValuesForKeysWithDictionary:data.pic];
            [picArray addObject:pic.url];
            self.picArray = picArray;
        }
        // 1-④
        if (_picArray != picArray) {
            _picArray = nil;
            _picArray = picArray;
        }
        
        NSString *typeNumber = [_typeArray objectAtIndex:indexPath.row];
//        NSLog(@"section%ld-%ld-type总类型个数是%ld-type型号是：%@",indexPath.section,modulesArray.count,typeArray.count,typeArray);
        
        if ([typeNumber isEqualToString:@"1"]) {
            CellType_1 *cell = [tableView dequeueReusableCellWithIdentifier:cellType_1];
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:_picArray[0]]];
//            NSLog(@"%ld--%@",indexPath.section,typeNumber);
            return cell;
        }else if ([typeNumber isEqualToString:@"2"]){
            CellType_2 *cell = [tableView dequeueReusableCellWithIdentifier:cellType_2];
            [cell.imgView_1 sd_setImageWithURL:[NSURL URLWithString:_picArray[0]]];
            [cell.imgView_2 sd_setImageWithURL:[NSURL URLWithString:_picArray[1]]];
//            NSLog(@"%ld--%@",indexPath.section,typeNumber);
            return cell;
        }else if ([typeNumber isEqualToString:@"3"]){
            CellType_3 *cell = [tableView dequeueReusableCellWithIdentifier:cellType_3];
            [cell.imgView_1 sd_setImageWithURL:[NSURL URLWithString:_picArray[0]]];
            [cell.imgView_2 sd_setImageWithURL:[NSURL URLWithString:_picArray[1]]];
            [cell.imgView_3 sd_setImageWithURL:[NSURL URLWithString:_picArray[2]]];
//            NSLog(@"%ld--%@",indexPath.section,typeNumber);
            return cell;
        }else if ([typeNumber isEqualToString:@"4"]){
            CellType_4 *cell = [tableView dequeueReusableCellWithIdentifier:cellType_4];
            [cell.imgView_1 sd_setImageWithURL:[NSURL URLWithString:_picArray[0]]];
            [cell.imgView_2 sd_setImageWithURL:[NSURL URLWithString:_picArray[1]]];
            [cell.imgView_3 sd_setImageWithURL:[NSURL URLWithString:_picArray[2]]];
            [cell.imgView_4 sd_setImageWithURL:[NSURL URLWithString:_picArray[3]]];
            [cell.imgView_5 sd_setImageWithURL:[NSURL URLWithString:_picArray[4]]];
//            NSLog(@"%ld--%@",indexPath.section,typeNumber);
            return cell;
        }else if ([typeNumber isEqualToString:@"7"]){
            
            CellType_7 *cell = [tableView dequeueReusableCellWithIdentifier:cellType_7];
            cell.cellScrollView.contentSize = CGSizeMake((kScreenW/3.0)*_picArray.count, cell.cellScrollView.frame.size.height);
            for (int i = 0; i < _picArray.count; i++) {
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenW/3*i, 0, kScreenW/3-2, cell.cellScrollView.frame.size.height)];
                [imgView sd_setImageWithURL:[NSURL URLWithString:_picArray[i]]];
                [cell.cellScrollView addSubview:imgView];
            }
//            NSLog(@"%ld--%@",indexPath.section,typeNumber);
            return cell;
        }
       
    }else{
        
        // 2-①
        NSMutableArray *outlet_itemsArray = [NSMutableArray array];
        NSMutableArray *image_indexArray = [NSMutableArray array];
        
        for (NSDictionary *listDic in _dict[@"content"][@"outlets_infos"]) {
            //            NSLog(@"💧->%@",listDic);
            Outlets_infos *outlets_infos = [Outlets_infos new];
            [outlets_infos setValuesForKeysWithDictionary:listDic];
            [image_indexArray addObject:outlets_infos.image_index];
            //            NSLog(@"%ld-💧💧->%@",image_indexArray.count,image_indexArray);
            
            [outlet_itemsArray addObject:outlets_infos.outlet_items];
            //            NSLog(@"%ld-💧💧💧->%@",outlet_itemsArray.count,outlet_itemsArray);
        }
        _image_indexArray = image_indexArray;
        if (_image_indexArray != image_indexArray) {
            _image_indexArray = nil;
            _image_indexArray = image_indexArray;
        }
        
        // 2-②
        _outlet_itemsArray = outlet_itemsArray;
        if (_outlet_itemsArray != outlet_itemsArray) {
            _outlet_itemsArray = nil;
            _outlet_itemsArray = outlet_itemsArray;
        }
        
        //         NSLog(@"🐲🐲🐲🐲🐲%@",_image_indexArray);
        if (indexPath.row == 0) {
            CellType_1 *cell = [tableView dequeueReusableCellWithIdentifier:cellType_1];
            NSDictionary *imageDic = _image_indexArray[indexPath.section - _listArray.count];
            Image_index *image_index = [Image_index new];
            [image_index setValuesForKeysWithDictionary:imageDic];
            //                NSLog(@"🐲🐲🐲🐲🐲%@",image_index.url);
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:image_index.url]];
            return cell;
        }else{
            // 2-③
            NSMutableArray *picArray = [NSMutableArray array];
            for (NSDictionary *outItemDict in _outlet_itemsArray[indexPath.section - _listArray.count]) {
//                NSLog(@"🐯🐯🐯🐯🐯🐯🐯🐯🐯%ld",(indexPath.section - _listArray.count));
                Outlet_items *items = [Outlet_items new];
                [items setValuesForKeysWithDictionary:outItemDict];
                [picArray addObject:items.pic[0]];
                //                NSLog(@"🐯🐯🐯🐯🐯%@",items.pic[0]);
            }
            
//            NSLog(@"🐯🐯🐯%ld",indexPath.section);
//            NSLog(@"🐯%ld",_picArray.count);
            
            _picArray = picArray;
            if (_picArray != picArray) {
                _picArray = nil;
                _picArray = picArray;
            }
            CellType_7 *cell = [tableView dequeueReusableCellWithIdentifier:cellType_7];
            cell.cellScrollView.contentSize = CGSizeMake((kScreenW/3.0)*_picArray.count, cell.cellScrollView.frame.size.height);
            cell.cellScrollView.pagingEnabled = YES;
            for (int i = 0; i < _picArray.count; i++) {
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenW/3*i, 0, kScreenW/3-3, cell.cellScrollView.frame.size.height)];
                imgView.backgroundColor = [UIColor clearColor];
                [imgView sd_setImageWithURL:[NSURL URLWithString:_picArray[i]]];
                [cell.cellScrollView addSubview:imgView];
            }
            return cell;
        }
        
    }
    
    return 0;
     */
    
//}



































/*

// TODO:选中触发事件--待优化，点击事件不对应
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section < self.listArray.count) {
        NSMutableArray *modulesArray = [NSMutableArray array];
        
        // 1
        for (NSDictionary *dic in self.listArray[indexPath.section]) {
            Modoules *modules = [Modoules new];
            [modules setValuesForKeysWithDictionary:dic];
            [modulesArray addObject:modules.data];
            
        }
       
        // 2
        _modulesArray = modulesArray;
        if (_modulesArray != modulesArray) {
            _modulesArray = nil;
            _modulesArray = modulesArray;
        }
        
        // 3
        for (NSDictionary *dataDict in _modulesArray[indexPath.row]) {
            Data *data = [Data new];
            [data setValuesForKeysWithDictionary:dataDict];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",data.url]]];
        }
        
    }else if (indexPath.section ==1){
        
        if (indexPath.row == 0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.miyabaobei.com/junsale/main/index"]];
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.mia.com/junesale/juneRedbag?miaShare=show"]];
        }
        
    }else if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.mia.com/special/module/index/5340/app/"]];
        }else if(indexPath.row == 1){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.mia.com/special/module/index/5341/app/"]];
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.mia.com/special/module/index/5339/app/"]];
        }
        
    }else if (indexPath.section == 3){
        
        if (indexPath.row == 0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.mia.com/special/module/index/4958/app/"]];
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.mia.com/special/module/index/4992/app/"]];
        }
    
    }else if (indexPath.section == 4){
        
        if (indexPath.row == 0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.mia.com/special/module/index/5094/app/"]];
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.mia.com/special/module/index/5362/app/"]];
        }
        
    }else if (indexPath.section == 5){
        //奶粉首页频道
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.mia.com/special/module/index/4037/wap/"]];
    }else if (indexPath.section == 6){
        //全球大牌纸尿裤28元起
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.mia.com/special/module/index/4852/wap/"]];
    }else if (indexPath.section == 7){
        
        if (indexPath.row == 0) {
            // 今日抢先购
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.mia.com/junesale/advancebuy/app?miaShare=show"]];
        }
        
    }else if (indexPath.section == 8){
        // TODO:di8
        if (indexPath.row == 0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.mia.com/junesale/advancebuy/app?miaShare=show&act=area2"]];
        }else{
           // 6.1免费日-宝宝营养全明星分会场
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.mia.com/special/module/index/4980/wap/"]];
        }
        
    }else if (indexPath.section == 9){
        //6.1免费日营养保健分
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.mia.com/special/module/index/4853/wap/"]];
    }else if (indexPath.section == 10){
    //6.1免费日家居俏货分
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.mia.com/special/module/index/4922/wap/"]];
    }else{
    
        NSMutableArray *modulesArray = [NSMutableArray array];
        for (NSDictionary *dic in self.listArray[indexPath.section]) {
            Modoules *modules = [Modoules new];
            [modules setValuesForKeysWithDictionary:dic];
            [modulesArray addObject:modules.data];
        }
        
        _modulesArray = modulesArray;
        if (_modulesArray != modulesArray) {
            _modulesArray = nil;
            _modulesArray = modulesArray;
        }
        
        for (NSDictionary *dataDict in _modulesArray[indexPath.row]) {
            Data *data = [Data new];
            [data setValuesForKeysWithDictionary:dataDict];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",data.url]]];
        }
    }
}


*/



@end
