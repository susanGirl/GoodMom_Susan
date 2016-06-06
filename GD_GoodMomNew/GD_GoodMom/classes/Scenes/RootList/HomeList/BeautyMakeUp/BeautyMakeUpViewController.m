//
//  BeautyMakeUpViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "BeautyMakeUpViewController.h"
#import "NetWorking.h"
@interface BeautyMakeUpViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *bannerScrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;




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


@end




static NSString * const cellType_1 = @"cellType_1_identifier";
static NSString * const cellType_2 = @"cellType_2_identifier";
static NSString * const cellType_3 = @"cellType_3_identifier";
static NSString * const cellType_4 = @"cellType_4_identifier";
static NSString * const cellType_7 = @"cellType_7_identifier";
@implementation BeautyMakeUpViewController

#define POST_YUN_URL @"http://api.miyabaobei.com/channel/template/"
#define POST_YUN_BODY @"sign=2df6d5bc1e7277833a0693817db7ec57&dvc_id=7b1d8112322eac6a647266388accce6c&session=868047022239927&android_mac=40%3Ac6%3A2a%3A3d%3A8e%3Ae8&channel_code=qq&version=android_4_1_1&bi_session_id=7b1d8112322eac6a647266388accce6c_1464607138615&app_id=android_app_id&timestamp=1464607584&device_token=3HnQZa6MCPr4BNhGwtMf2ie9N8AvCyrSFLawTixLB%2FA%3D&regid=3HnQZa6MCPr4BNhGwtMf2ie9N8AvCyrSFLawTixLB%2FA%3D&auth_session=&params=GxskbDxPn56EtwBwjy_i3HJQ9Utthkf3bcLB31BpWcu169zVWk6u61za7X9kjhmp9X6wRpp9eZ6-TL63lEMYShuo2bBweWlPTzZNHUiCOJ-IgBlYpmSBS1y19szSUgJD1Xy1YHnkPJWBUAIHkqx_Upo7jfFEu0njDqNiAdoTaqM%3D&"

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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 注册cell
 
    [_tableView registerNib:[UINib nibWithNibName:@"CellType_1" bundle:nil] forCellReuseIdentifier:cellType_1];
    [_tableView registerNib:[UINib nibWithNibName:@"CellType_2" bundle:nil] forCellReuseIdentifier:cellType_2];
    [_tableView registerNib:[UINib nibWithNibName:@"CellType_3" bundle:nil] forCellReuseIdentifier:cellType_3];
    [_tableView registerNib:[UINib nibWithNibName:@"CellType_4" bundle:nil] forCellReuseIdentifier:cellType_4];
    [_tableView registerNib:[UINib nibWithNibName:@"CellType_7" bundle:nil] forCellReuseIdentifier:cellType_7];
    
    
    [self netWorkingAndSetUp];
    [self netWorkingWithTableView];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

#pragma mark -- 美妆
#pragma mark --轮播图
// 解析数据并画图赋值
- (void)netWorkingAndSetUp{
    
    self.post_Url = @"http://api.miyabaobei.com/channel/banner/";
    self.post_Body = @"sign=a21a6937493989269690c13657b1d766&dvc_id=7b1d8112322eac6a647266388accce6c&session=868047022239927&android_mac=40%3Ac6%3A2a%3A3d%3A8e%3Ae8&channel_code=qq&version=android_4_1_1&bi_session_id=7b1d8112322eac6a647266388accce6c_1464607138615&app_id=android_app_id&timestamp=1464607584&device_token=3HnQZa6MCPr4BNhGwtMf2ie9N8AvCyrSFLawTixLB%2FA%3D&regid=3HnQZa6MCPr4BNhGwtMf2ie9N8AvCyrSFLawTixLB%2FA%3D&auth_session=&params=HpaW3Q7OetoZ1gy-YVpAbObC5HIBu-McD7lpKE0JUcXAqv3mtGbGwhL6AFZ1wsjIHqGEMIZ8fIoGv2dyGV3I2uKQcZ7i-hVpOFLgtWutsIoOU34vzO84MEMUl_1pr9A-ani3uOxu8Kc9yyRQvopYGPB6zdYQPgDy8pndeekcbZw%3D&";
    
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
//        NSLog(@"❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️美妆-->解析");
        _count = self.imagesArray.count;
//        NSLog(@"%ld",_count);
        [self drawView];
    }];
    
    
}
- (void)drawView{
    
    
    // 设置显示内容区域大小
    
    self.bannerScrollView.contentSize = CGSizeMake(kScreenW*self.imagesArray.count, self.bannerScrollView.frame.size.height);
    
    _bannerScrollView.delegate =self;
    for (int i = 0; i < _count; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenW*i, CGRectGetMinY(self.bannerScrollView.frame), kScreenW, CGRectGetMaxY(self.bannerScrollView.frame))];
        [imgView sd_setImageWithURL:[NSURL URLWithString:self.imagesArray[i]]];
        
        [self.bannerScrollView addSubview:imgView];
    }
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, self.imagesArray.count * 15, 50)];
    _pageControl.center = CGPointMake(self.view.center.x, CGRectGetMaxY(_bannerScrollView.frame)-25);
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
    [self.bannerScrollView setContentOffset:CGPointMake(self.pageControl.currentPage*kScreenW, 0) animated:YES];
    
}
- (void)pageControlAction:(UIPageControl *)pageControl{
    
    self.bannerScrollView.contentOffset = CGPointMake(pageControl.currentPage * kScreenW,0);
    
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
        
//        [self.listArray removeObjectAtIndex:0];
        //        for (int i = 0; i < self.listArray.count; i++) {
        ////            NSLog(@"%d🔥🔥🔥%@🔥🔥🔥",i,self.listArray[i]);
        //        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // 回到主线程-->切记刷新-->刷新UI
            [self.tableView reloadData];
        });
        
    }];

/*
#pragma mark--tableView下半部分
#define post_url  @"http://api.miyabaobei.com/channel/outlet/"
#define post_body   @"sign=d19ca07917c166cd73ae53671daaaef2&dvc_id=7b1d8112322eac6a647266388accce6c&session=868047022239927&android_mac=40%3Ac6%3A2a%3A3d%3A8e%3Ae8&channel_code=qq&version=android_4_1_1&bi_session_id=7b1d8112322eac6a647266388accce6c_1464607138615&app_id=android_app_id&timestamp=1464607584&device_token=3HnQZa6MCPr4BNhGwtMf2ie9N8AvCyrSFLawTixLB%2FA%3D&regid=3HnQZa6MCPr4BNhGwtMf2ie9N8AvCyrSFLawTixLB%2FA%3D&auth_session=&params=ZRb_LaaNoICnRWQaV7mZEXAYQUZLv1Mea9TB6YRvUXXaKB24AUciXYVJhjUt8O4brB1_DIi8PSspeJ_hLl956cF6I33A1Tcw_lQV4ZiFBI7UF6rqqP2RMWRgIiv2Y_YBQDJhele02hv3hz1Ip74wwRQf-D8u-9G52fD3FG2e9oA%3D&"
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
*/
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    //    NSLog(@"%ld-🔥🔥🔥%ld",self.listArray.count,_outlets_infosArray.count);
    return self.listArray.count;//+self.outlets_infosArray.count;
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
    
//    if (indexPath.section < self.listArray.count) {
//        if (indexPath.section == 0 || indexPath.section == 2) {
//            return 70;
//        }else if (indexPath.section == 4 || indexPath.section == 5){
//            
//            if (indexPath.row == 0) {
//                return 70;
//            }
//            return kScreenWidth/2;
//        }
//        return kScreenWidth/2;
//    }
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
                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenW/3*i, 0, kScreenW/3-2, cell.cellScrollView.frame.size.height)];
                [imgView sd_setImageWithURL:[NSURL URLWithString:_picArray[i]]];
                [cell.cellScrollView addSubview:imgView];
            }
            return cell;
        }
        
    }
    
    return 0;
}

@end;