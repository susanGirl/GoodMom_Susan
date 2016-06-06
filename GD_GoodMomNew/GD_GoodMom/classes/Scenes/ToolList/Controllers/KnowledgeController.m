//
//  KnowledgeController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/2.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "KnowledgeController.h"
#import "KnowledgeCell.h"//自定义cell
#import "KnowDetailViewController.h"//分组界面
#import "KnowTitleViewController.h"//题目界面

@interface KnowledgeController ()
//time数组
@property(nonatomic,strong)NSMutableArray *AllTime;
//times数组
@property(nonatomic,strong)NSMutableArray *AllTimes;

@end
static NSString * const tableViewCellID = @"systemCellID";
@implementation KnowledgeController


- (void)viewDidLoad {
    [super viewDidLoad];
    //数据
    [self setDataUpdata];
    //注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewCellID];

}
//数据解析
- (void)setDataUpdata{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Knowledge.plist" ofType:nil];
    NSArray *timeArray = [NSArray arrayWithContentsOfFile:path];
    _AllTime = [NSMutableArray array].mutableCopy;
    _AllTimes = [NSMutableArray array].mutableCopy;
    for (NSDictionary *dic in timeArray) {
        NSString *time = dic[@"time"];
        [_AllTime addObject:[NSString stringWithFormat:@"%@",time]];
        NSArray *tempArray = dic[@"times"];
        [_AllTimes addObject:tempArray];
    }
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _AllTime.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellID forIndexPath:indexPath];
    cell.textLabel.text = _AllTime[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row <= 5) {
        KnowDetailViewController *knowDetailVC = [[KnowDetailViewController alloc]init];
        knowDetailVC.timesArray = _AllTimes[indexPath.row];
        knowDetailVC.timesName = _AllTime[indexPath.row];
        [self.navigationController pushViewController:knowDetailVC animated:YES];
    }
//        else if(indexPath.row == 5){
//        KnowTitleViewController *knowTileVC = [[KnowTitleViewController alloc]init];
//        knowTileVC.titleArray = _AllTimes[indexPath.row];
//        knowTileVC.titleName = _AllTime[indexPath.row];
//        [self.navigationController pushViewController:knowTileVC animated:YES];
//    }
   
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
