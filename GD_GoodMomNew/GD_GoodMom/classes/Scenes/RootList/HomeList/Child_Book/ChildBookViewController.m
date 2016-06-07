//
//  ChildBookViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/1.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "ChildBookViewController.h"
#import "WebViewController.h"
#import "BookCell.h"

@interface ChildBookViewController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(strong,nonatomic)NSString  *cellTitle;
@property(strong,nonatomic)NSTimer  *timer;
@property(assign,nonatomic)NSInteger  number;

@end

static NSString * const bookCellId = @"bookCellidentifier";
@implementation ChildBookViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册bookCell
    [_tableView registerNib:[UINib nibWithNibName:@"BookCell" bundle:nil] forCellReuseIdentifier:bookCellId];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 11;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    BookCell *cell = [_tableView dequeueReusableCellWithIdentifier:bookCellId];
    if (indexPath.section == 0) {
        [self bookCell:cell title:@"中文绘本" name:@"图书_01.png" name:@"图书_02.png" name:@"图书_03.png" name:@"图书_04.png" name:@"图书_05.png"];
        return cell;
    }else if (indexPath.section == 1){
        [self bookCell:cell title:@"科普百科" name:@"图书_06.png" name:@"图书_07.png" name:@"图书_08.png" name:@"图书_09.png" name:@"图书_10.png"];
    }else if (indexPath.section == 2){
        [self bookCell:cell title:@"儿童文学" name:@"图书_11.png" name:@"图书_12.png" name:@"图书_13.png" name:@"图书_14.png" name:@"图书_15.png"];
    }else if (indexPath.section == 3){
        [self bookCell:cell title:@"启蒙教育" name:@"图书_16.png" name:@"图书_17.png" name:@"图书_18.png" name:@"图书_19.png" name:@"图书_20.png"];
    }else if (indexPath.section == 4){
        [self bookCell:cell title:@"孕产育儿" name:@"图书_21.png" name:@"图书_22.png" name:@"图书_23.png" name:@"图书_24.png" name:@"图书_25.png"];
    }else if (indexPath.section == 5){
        [self bookCell:cell title:@"期刊杂志" name:@"图书_26.png" name:@"图书_27.png" name:@"图书_28.png" name:@"图书_29.png" name:@"图书_30.png"];
    }else if (indexPath.section == 6){
        [self bookCell:cell title:@"生活休闲" name:@"图书_31.png" name:@"图书_32.png" name:@"图书_33.png" name:@"图书_34.png" name:@"图书_35.png"];
    }else if (indexPath.section == 7){
        [self bookCell:cell title:@"原版进口" name:@"图书_36.png" name:@"图书_37.png" name:@"图书_38.png" name:@"图书_39.png" name:@"图书_40.png"];
    }else if (indexPath.section == 8){
        [self bookCell:cell title:@"有声读物" name:@"图书_41.png" name:@"图书_42.png" name:@"图书_43.png" name:@"图书_44.png" name:@"图书_45.png"];
    }else if (indexPath.section == 9){
        [self bookCell:cell title:@"手工玩具" name:@"图书_46.png" name:@"图书_47.png" name:@"图书_48.png" name:@"图书_49.png" name:@"图书_50.png"];
    }else{
        [self bookCell:cell title:@"卡通动漫" name:@"图书_51.png" name:@"图书_52.png" name:@"图书_53.png" name:@"图书_54.png" name:@"图书_55.png"];
    }
    return cell;
}

- (UITableViewCell *)bookCell:(BookCell *)cell title:(NSString *)title name:(NSString *)name_1 name:(NSString *)name_2 name:(NSString *)name_3 name:(NSString *)name_4 name:(NSString *)name_5{
    cell.cellScrollView.contentSize = CGSizeMake(cell.imgView_1.frame.size.width*5+40, cell.imgView_1.frame.size.height);
    cell.cellScrollView.pagingEnabled = YES;
    cell.cellScrollView.delegate = self;
    cell.cellScrollView.bounces = NO;
    cell.imgView_1.image = [UIImage imageNamed:name_1];
    cell.imgView_1.userInteractionEnabled = YES;
    cell.imgView_2.image = [UIImage imageNamed:name_2];
    cell.imgView_3.image = [UIImage imageNamed:name_3];
    cell.imgView_4.image = [UIImage imageNamed:name_4];
    cell.imgView_5.image = [UIImage imageNamed:name_5];
//    [self starTimer:self cell:cell];
    return cell;
}

//- (void)starTimer:(UIViewController *)viewVC cell:(BookCell *)cell{
//    
//    cell.cellScrollView.contentSize = CGSizeMake(cell.imgView_1.frame.size.width*5+40, cell.cellScrollView.frame.size.height);
//    cell.cellScrollView.delegate = self;
//    cell.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 5 * 15, 50)];
//    cell.pageControl.center = CGPointMake(cell.cellScrollView.center.x, CGRectGetMaxY(cell.cellScrollView.frame)-25);
//    cell.pageControl.numberOfPages = 5;
//    // 选中的颜色
//    cell.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:241/255.0 green:158/255.0 blue:194/255.0 alpha:1];
//    // 未选中的颜色
//    cell.pageControl.pageIndicatorTintColor = [UIColor redColor];
//    [cell.cellScrollView addSubview:cell.pageControl];///////
//    [cell.pageControl addTarget:self action:@selector(pageControlAction:cell:) forControlEvents:UIControlEventValueChanged];
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:viewVC selector:@selector(timerAction:) userInfo:nil repeats:YES];
//}
//- (void)timerAction:(BookCell *)cell{
//    _number = cell.pageControl.currentPage;
//    _number++;
//    if (_number == 5) {
//        _number = 0;
//    }
//    cell.pageControl.currentPage = _number;
//    [cell.cellScrollView setContentOffset:CGPointMake(cell.pageControl.currentPage*(cell.imgView_1.frame.size.width+8), 0) animated:YES];
//    
//}
//- (void)pageControlAction:(UIPageControl *)pageControl cell:(BookCell *)cell{
//    
//    cell.cellScrollView.contentOffset = CGPointMake(pageControl.currentPage * (cell.imgView_1.frame.size.width+8),0);
//    
//}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"aaaa");
    
    
    if (indexPath.section == 0) {
        [self pushWebView:@"http://www.mia.com/s/cat292_tid861.html"];
    }else if (indexPath.section == 1) {
        [self pushWebView:@"http://www.mia.com/s/cat296_tid865.html"];
    }else if (indexPath.section == 2) {
        [self pushWebView:@"http://www.mia.com/s/cat297_tid866.html"];
    }else if (indexPath.section == 3) {
        [self pushWebView:@"http://www.mia.com/s/cat298_tid867.html"];
    }else if (indexPath.section == 4) {
        [self pushWebView:@"http://www.mia.com/s/cat299_tid868.html"];
    }else if (indexPath.section == 5) {
        [self pushWebView:@"http://www.mia.com/s/cat300_tid869.html"];
    }else if (indexPath.section == 6) {
        [self pushWebView:@"http://www.mia.com/s/cat301_tid870.html"];
    }else if (indexPath.section == 7) {
        [self pushWebView:@"http://www.mia.com/s/cat328_tid931.html"];
    }else if (indexPath.section == 8) {
        [self pushWebView:@"http://www.mia.com/s/cat294_tid863.html"];
    }else if (indexPath.section == 9) {
        [self pushWebView:@"http://www.mia.com/s/cat293_tid862.html"];
    }else{
        [self pushWebView:@"http://www.mia.com/s/cat295_tid864.html"];
    }
}

- (void)pushWebView:(NSString *)url{
    
    WebViewController *webViewVC = [WebViewController new];
    
    webViewVC.webView.scalesPageToFit = YES;// 是否自适应
    
    webViewVC.webViewUrl = url;
    
    [self.navigationController pushViewController:webViewVC animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        _cellTitle = @"中文绘本";
    }else if (section == 1){
        _cellTitle = @"科普百科";
    }else if (section == 2){
        _cellTitle = @"儿童文学";
    }else if (section == 3){
        _cellTitle = @"启蒙教育";
    }else if (section == 4){
        _cellTitle = @"孕产育儿";
    }else if (section == 5){
        _cellTitle = @"期刊杂志";
    }else if (section == 6){
        _cellTitle = @"生活休闲";
    }else if (section == 7){
        _cellTitle = @"原版进口";
    }else if (section == 8){
        _cellTitle = @"有声读物";
    }else if (section == 9){
        _cellTitle = @"手工玩具";
    }else{
        _cellTitle = @"卡通动漫";
    }
    return _cellTitle;
}
@end
