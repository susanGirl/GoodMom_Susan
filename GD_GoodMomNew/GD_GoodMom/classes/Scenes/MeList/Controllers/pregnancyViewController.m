//
//  pregnancyViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/28.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "pregnancyViewController.h"
#import "PNChart.h"
@interface pregnancyViewController ()
@property(nonatomic,strong)UISearchController *searchController;

@end

@implementation pregnancyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];

    //初始化搜索框
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchController.searchBar.searchResultsButtonSelected = NO;
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width - 130, 40);
    
    //搜索时背景变模糊
//    self.searchController.obscuresBackgroundDuringPresentation = YES;
    //是否隐藏导航栏
    self.searchController.hidesNavigationBarDuringPresentation = NO;

    [self.view addSubview:self.searchController.searchBar];
    
  [self getLineChart];
    

}
-(void)getLineChart{

    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 400.0)];
    [lineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
    
    // Line Chart No.1
    NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = PNTwitterColor;
    data02.itemCount = lineChart.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChart.chartData = @[data01, data02];
    [lineChart strokeChart];
    [self.view addSubview:lineChart];

    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
