//
//  YunYingViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "YunYingViewController.h"
#import "NetWorking.h"
#import <UIImageView+WebCache.h>



#import "CustomCell.h"
#define POST_YUN_URL @"http://api.miyabaobei.com/channel/template/"
#define POST_YUN_BODY @"sign=c98fcf56032789efd4c130efe9d0975f&dvc_id=7b1d8112322eac6a647266388accce6c&session=868047022239927&android_mac=40%3Ac6%3A2a%3A3d%3A8e%3Ae8&channel_code=qq&version=android_4_1_1&bi_session_id=7b1d8112322eac6a647266388accce6c_1464357194024&app_id=android_app_id&timestamp=1464357282&device_token=3HnQZa6MCPr4BNhGwtMf2ie9N8AvCyrSFLawTixLB%2FA%3D&regid=3HnQZa6MCPr4BNhGwtMf2ie9N8AvCyrSFLawTixLB%2FA%3D&auth_session=&params=jVkoupVXArxPgVPYR8UirgsvL6pUZ5zDe_tTDGiQIsYQvzw_MVxUxnHG2Bz3M_T8YS3KG0BKgM0Tia4CvKmhwQUiF_U9c8lNZQfbzddgE9MXP2CQOTHHExtvsBtAcK4piTjsd7jpiGiCQg1RwMpjuKe3tw1CwBLQiubMefPgrVs%3D&"
@interface YunYingViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>

@property (strong, nonatomic) UIScrollView *imagesScrollView;

@property(strong,nonatomic) UIPageControl *pageControl;
@property(strong,nonatomic)NSMutableArray  *imagesArray;// 图片数组
@property(strong,nonatomic)NSString  *post_Url;
@property(strong,nonatomic)NSString  *post_Body;
@property(strong,nonatomic)NSTimer  *timer;// 计时器
@property(assign,nonatomic)NSInteger  count;
@property(assign,nonatomic)NSInteger  number;


@property(strong,nonatomic)NSMutableArray  *listArray;// 数据总列表section个数的数组
@property(strong,nonatomic)NSMutableArray  *modulesArray;// 每列数据中row个数的数组
@property(strong,nonatomic)NSMutableArray  *dataArray;// 每个row中的图片个数的数组
@property(strong,nonatomic)NSMutableArray  *picArray;
@property(strong,nonatomic)NSMutableArray  *typeArray;

@property(strong,nonatomic)NSMutableArray  *outlets_infosArray;
@property(strong,nonatomic)NSMutableArray  *outlet_itemsArray;
@property(strong,nonatomic)NSMutableArray  *image_indexArray;
@property(strong,nonatomic)NSMutableDictionary  *dict;

@property(strong,nonatomic)UITableView  *tableView;
@end

static NSString * const customCellID = @"customCellReuseIdentifier";

static NSString * const cellType_1 = @"cellType_1_identifier";
static NSString * const cellType_2 = @"cellType_2_identifier";
static NSString * const cellType_3 = @"cellType_3_identifier";
static NSString * const cellType_4 = @"cellType_4_identifier";
static NSString * const cellType_7 = @"cellType_7_identifier";
@implementation YunYingViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
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
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 50)];// 只有高度有作用
    header.backgroundColor = [UIColor cyanColor];
    _tableView.tableHeaderView = header;
    
    
    // 创建tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (kScreenW*5/8)+130, kScreenW, kScreenH-130-(kScreenW*5/8)-50) style:UITableViewStylePlain];
    _tableView.separatorColor = [UIColor redColor];
    // 设置代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 注册cell
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:customCellID];
    [_tableView registerNib:[UINib nibWithNibName:@"CellType_1" bundle:nil] forCellReuseIdentifier:cellType_1];
    [_tableView registerNib:[UINib nibWithNibName:@"CellType_2" bundle:nil] forCellReuseIdentifier:cellType_2];
    [_tableView registerNib:[UINib nibWithNibName:@"CellType_3" bundle:nil] forCellReuseIdentifier:cellType_3];
    [_tableView registerNib:[UINib nibWithNibName:@"CellType_4" bundle:nil] forCellReuseIdentifier:cellType_4];
    [_tableView registerNib:[UINib nibWithNibName:@"CellType_7" bundle:nil] forCellReuseIdentifier:cellType_7];
    // 添加到视图上
    [self.view addSubview:self.tableView];
    
    [self setUp];
    [self netWorkingAndSetUp];
    [self netWorkingWithTableView];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

#pragma mark -- 孕婴
#pragma mark --轮播图
// 解析数据并画图赋值
- (void)netWorkingAndSetUp{
    
    _imagesScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW*5/8)];
    [self.view addSubview:_imagesScrollView];
    self.post_Url = @"http://api.miyabaobei.com/channel/banner/";
    self.post_Body = @"sign=173d6234cc91b79c632f5fa798c6be2e&dvc_id=7b1d8112322eac6a647266388accce6c&session=868047022239927&android_mac=40%3Ac6%3A2a%3A3d%3A8e%3Ae8&channel_code=qq&version=android_4_1_1&bi_session_id=7b1d8112322eac6a647266388accce6c_1464091662582&app_id=android_app_id&timestamp=1464092083&device_token=3HnQZa6MCPr4BNhGwtMf2ie9N8AvCyrSFLawTixLB%2FA%3D&regid=3HnQZa6MCPr4BNhGwtMf2ie9N8AvCyrSFLawTixLB%2FA%3D&auth_session=&params=jSYZgo2Vk1VEFryM_T8BbmTwkNSqpFz3fkcSnwXLRIZtjxLK5xxtXtoGf6Y30ZlfoYTBonTZoTUj5BScJjrQU3WmybC2wrcSpXtVlRYoYN-8bn88snwjFGA1mi3FVDy9wAvIlpKKm308Cw-i9173XACwyepj7PQxZCcqpcDyswY%3D&";
    
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
        NSLog(@"❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️孕婴-->解析");
        _count = self.imagesArray.count;
        NSLog(@"%ld",_count);
        [self drawView];
    }];
    
    
}
- (void)drawView{
    
    
    // 设置显示内容区域大小
    
    self.imagesScrollView.contentSize = CGSizeMake(kScreenW*self.imagesArray.count, self.imagesScrollView.frame.size.height);
    
    _imagesScrollView.delegate =self;
    for (int i = 0; i < _count; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenW*i, CGRectGetMinY(self.imagesScrollView.frame), kScreenW, CGRectGetMaxY(self.imagesScrollView.frame))];
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
    [self.imagesScrollView setContentOffset:CGPointMake(self.pageControl.currentPage*kScreenW, 0) animated:YES];
    
}
- (void)pageControlAction:(UIPageControl *)pageControl{
    
    self.imagesScrollView.contentOffset = CGPointMake(pageControl.currentPage * kScreenW,0);
    
}
#pragma mark --CollectionView
- (void)setUp{
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    // 设置每个item的大小
    flowLayout.itemSize = CGSizeMake((kScreenW-80)/3, 50);
    // 设置单个分区距离上下左右的位置
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, (kScreenW*5/8), kScreenW, 130) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.pagingEnabled = YES;

    [collectionView setTag:101];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;

    // 注册自定义cell
    [collectionView registerClass:[CustomCell class] forCellWithReuseIdentifier:customCellID];
    [self.view addSubview:collectionView];
    
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
            cell.imgView.image = [UIImage imageNamed:@"防晒"];
        }else if (indexPath.row == 1){
            
            cell.imgView.image = [UIImage imageNamed:@"奶瓶"];
        }else{
            
            cell.imgView.image = [UIImage imageNamed:@"孕产.jpg"];
        }
    }else{
        if (indexPath.row == 0) {
            cell.imgView.image = [UIImage imageNamed:@"米粉"];
        }else if (indexPath.row == 1){
            
            cell.imgView.image = [UIImage imageNamed:@"推车"];
        }else{
            
            cell.imgView.image = [UIImage imageNamed:@"凉席.jpg"];
        }
    }
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.mia.com/special/module/index/4091/app/"]];
            
            [webView setDelegate:self];
            [self.view addSubview:webView];
            [webView loadRequest:request];
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@""]];
        }else if (indexPath.row == 1){
        
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.mia.com/search/s?k=%E5%A5%B6%E7%93%B6"]];
        }else{
        
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.mia.com/special/module/index/3334/app/"]];
        }
    }else{
        if (indexPath.row == 0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.mia.com/search/s?k=%E7%B1%B3%E7%B2%89"]];
        }else if (indexPath.row == 1){
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.mia.com/search/s?k=%E6%8E%A8%E8%BD%A6"]];
        }else{
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.mia.com/search/s?k=%E5%87%89%E5%B8%AD"]];
        }
    }
}
#pragma mark --tableView
- (void)netWorkingWithTableView{

    [NetWorking netWorkingPostActionWithURLString:POST_YUN_URL bodyURLString:POST_YUN_BODY completeHandle:^(NSData * _Nullable data) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"🔥🔥🔥%@🔥🔥🔥",dict); //通过！！！有数据
        for (NSDictionary *listDic in dict[@"content"][@"list"]) {
            HomeModel *home = [HomeModel new];
            [home setValuesForKeysWithDictionary:listDic];
//            NSLog(@"🔥🔥🔥%@🔥🔥🔥",home.modules);
            [self.listArray addObject:home.modules];
//            NSLog(@"%ld-🔥🔥🔥->%@",self.listArray.count,self.listArray);
        }
        
        [self.listArray removeObjectAtIndex:0];
//        for (int i = 0; i < self.listArray.count; i++) {
////            NSLog(@"%d🔥🔥🔥%@🔥🔥🔥",i,self.listArray[i]);
//        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // 回到主线程-->切记刷新-->刷新UI
            [self.tableView reloadData];
        });
        
    }];
    
#pragma mark--tableView下半部分
#define post_url  @"http://api.miyabaobei.com/channel/outlet/"
#define post_body   @"sign=68d2d27e74dc27de8436555b89ca7de4&dvc_id=7b1d8112322eac6a647266388accce6c&session=868047022239927&android_mac=40%3Ac6%3A2a%3A3d%3A8e%3Ae8&channel_code=qq&version=android_4_1_1&bi_session_id=7b1d8112322eac6a647266388accce6c_1464357194024&app_id=android_app_id&timestamp=1464357282&device_token=3HnQZa6MCPr4BNhGwtMf2ie9N8AvCyrSFLawTixLB%2FA%3D&regid=3HnQZa6MCPr4BNhGwtMf2ie9N8AvCyrSFLawTixLB%2FA%3D&auth_session=&params=DQ6NiefS6kJO6yBG6RAkgen8_LP_fMvYwXp10waS_kVuIu--WvIKlQVHVZsBssJa1EgRybKkqs2Zdqp7V_bgTydwB9g30yiLpiDnkpULT9wO2qtgXbMK9rg3H9f2hoHFbcFNRXUwhmDnXNfhn-sfU0Wzt22K-Zgw4OeMXYdy8wE%3D&"
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
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 回到主线程-->切记刷新-->刷新UI
            [self.tableView reloadData];
        });
        
    }];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

//    NSLog(@"%ld-🔥🔥🔥%ld",self.listArray.count,_outlets_infosArray.count);
    return self.listArray.count+self.outlets_infosArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSMutableArray *modulesArray = [NSMutableArray array];
    NSMutableArray *typeArray = [NSMutableArray array];
    if (section < self.listArray.count) {
        for (NSDictionary *dic in self.listArray[section]) {
            Modoules *modules = [Modoules new];
            [modules setValuesForKeysWithDictionary:dic];
            [modulesArray addObject:modules.data];
            
            [typeArray addObject:modules.type];
//            NSLog(@"section%ld-%ld-%ld-%@",section,modulesArray.count,typeArray.count,typeArray);
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
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    UITableViewCell *cell = [self index:indexPath tableView:tableView];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

//        if (indexPath.section < self.listArray.count) {
//            if (indexPath.section == 0 || indexPath.section == 2) {
//                return 70;
//            }else if (indexPath.section == 4 || indexPath.section == 5){
//                
//                if (indexPath.row == 0) {
//                    return 70;
//                }
//                return kScreenWidth/2;
//            }
//            return kScreenWidth/2;
//        }
    return kScreenW/2;
}
// 绘制tableViewCell时调用的私有方法

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
- (UITableViewCell *)index:(NSIndexPath *)indexPath tableView:(UITableView *)tableView{
        //==========
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
        _typeArray = typeArray;
        if (_typeArray != typeArray) {
            _typeArray = nil;
            _typeArray = typeArray;
        }
        
        // 1-②
        _modulesArray = modulesArray;
        if (_modulesArray != modulesArray) {
            _modulesArray = nil;
            _modulesArray = modulesArray;
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
//        NSLog(@"=====section%ld✨✨✨%ld=%ld✨✨type%@",indexPath.section,_typeArray.count,_picArray.count,_typeArray);
        NSString *typeNumber = [_typeArray objectAtIndex:indexPath.row];
        
       
        
        
        if ([typeNumber isEqualToString:@"1"]) {
            CellType_1 *cell = [tableView dequeueReusableCellWithIdentifier:cellType_1];
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:_picArray[0]]];
//             NSLog(@"%ld--%@",indexPath.section,typeNumber);
            return cell;
        }else if ([typeNumber isEqualToString:@"2"]){
            CellType_2 *cell = [tableView dequeueReusableCellWithIdentifier:cellType_2];
            [cell.imgView_1 sd_setImageWithURL:[NSURL URLWithString:_picArray[0]]];
            [cell.imgView_2 sd_setImageWithURL:[NSURL URLWithString:_picArray[1]]];
//             NSLog(@"%ld--%@",indexPath.section,typeNumber);
            return cell;
        }else if ([typeNumber isEqualToString:@"3"]){
            CellType_3 *cell = [tableView dequeueReusableCellWithIdentifier:cellType_3];
            [cell.imgView_1 sd_setImageWithURL:[NSURL URLWithString:_picArray[0]]];
            [cell.imgView_2 sd_setImageWithURL:[NSURL URLWithString:_picArray[1]]];
            [cell.imgView_3 sd_setImageWithURL:[NSURL URLWithString:_picArray[2]]];
//             NSLog(@"%ld--%@",indexPath.section,typeNumber);
            return cell;
        }else if ([typeNumber isEqualToString:@"4"]){
            CellType_4 *cell = [tableView dequeueReusableCellWithIdentifier:cellType_4];
            [cell.imgView_1 sd_setImageWithURL:[NSURL URLWithString:_picArray[0]]];
            [cell.imgView_2 sd_setImageWithURL:[NSURL URLWithString:_picArray[1]]];
            [cell.imgView_3 sd_setImageWithURL:[NSURL URLWithString:_picArray[2]]];
            [cell.imgView_4 sd_setImageWithURL:[NSURL URLWithString:_picArray[3]]];
            [cell.imgView_5 sd_setImageWithURL:[NSURL URLWithString:_picArray[4]]];
//             NSLog(@"%ld--%@",indexPath.section,typeNumber);
            return cell;
        }else if ([typeNumber isEqualToString:@"7"]){
            
            CellType_7 *cell = [tableView dequeueReusableCellWithIdentifier:cellType_7];
            cell.cellScrollView.contentSize = CGSizeMake((kScreenW/3.0)*_picArray.count, cell.cellScrollView.frame.size.height);
            for (int i = 0; i < _picArray.count; i++) {
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenW/3*i, 0, kScreenW/3-2, cell.cellScrollView.frame.size.height)];
                [imgView sd_setImageWithURL:[NSURL URLWithString:_picArray[i]]];
                [cell.cellScrollView addSubview:imgView];
            }
//             NSLog(@"%ld--%@",indexPath.section,typeNumber);
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
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenW/3*i, 0, kScreenW/3-2, cell.cellScrollView.frame.size.height)];
                [imgView sd_setImageWithURL:[NSURL URLWithString:_picArray[i]]];
                [cell.cellScrollView addSubview:imgView];
            }
            return cell;
        }
    
    }
    
    return 0;
}

//    return cell;















// 点击cell触发事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0 || indexPath.section == 3 || indexPath.section == 5) {
        
        
        
    }else if (indexPath.section == 1 || indexPath.section == 2){
        
    
   
    }else if (indexPath.section == 4){
        
        

    }else{
        
       
      
    }

}






// 点击对应图片执行对应的功能，---->>>未实现
- (void)indexPath:(NSIndexPath *)indexPath imgView:(UIImageView *)imgView{

    NSMutableArray *modulesArray = [NSMutableArray array];
    for (NSDictionary *dic in self.listArray[indexPath.section]) {
        Modoules *modules = [Modoules new];
        [modules setValuesForKeysWithDictionary:dic];
        [modulesArray addObject:modules.data];
        //                        NSLog(@"=====✨✨✨data✨✨%@",modules.data);
    }
    _modulesArray = modulesArray;
    if (_modulesArray != modulesArray) {
        _modulesArray = nil;
        _modulesArray = modulesArray;
    }
    
    NSMutableArray *picArray = [NSMutableArray array];
    for (NSDictionary *dataDict in _modulesArray[indexPath.row]) {
        Data *data = [Data new];
        [data setValuesForKeysWithDictionary:dataDict];
        
        [picArray addObject:data.url];
        self.picArray = picArray;
    }
    if (_picArray != picArray) {
        _picArray = nil;
        _picArray = picArray;
    }

}

@end
