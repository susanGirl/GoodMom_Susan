//
//  KnowDetailViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/2.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "KnowDetailViewController.h"
#import "KnowledgeModel.h"
#import "KnowTitleModel.h"
#import "KnowTitleViewController.h"

@interface KnowDetailViewController ()
//分组的数组
@property(nonatomic,strong)NSMutableArray *allGroup;
//cell数组
@property(nonatomic,strong)NSMutableArray *allCell;
//groups数组
@property(nonatomic,strong)NSMutableArray *allGroups;
//全部数据
@property(nonatomic,strong)NSMutableDictionary *allData;
//全部数组
@property(nonatomic,strong)NSMutableDictionary *allDatas;
//cells数组
@property(nonatomic,strong)NSMutableArray *allCells;

@end
static NSString * const cellID = @"cellID";
@implementation KnowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _timesName;
    //数据
    [self setDataUpdata];
    //注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
   
}
//数据解析
-(void)setDataUpdata{
    _allGroup = [NSMutableArray array];//所有的分组和cell的数组
    _allData = [NSMutableDictionary dictionary];
    for (NSDictionary *dict in _timesArray) {
        KnowledgeModel * model = [KnowledgeModel new];
        [model setValuesForKeysWithDictionary:dict];
        //所有的分区以及cell
        [_allGroup addObject:model];
    }
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    KnowledgeModel *model = [KnowledgeModel new];
    model = _allGroup[section];
    return model.group;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    NSLog(@"allGroup.count = %ld",_allGroup.count);
    return _allGroup.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
//    _allCell = [NSMutableArray array];
//    for(NSDictionary *dict  in _allGroups){
//    
//        KnowledgeModel *mo = [KnowledgeModel new];
//        [mo setValuesForKeysWithDictionary:dict];
////        NSLog(@"%@-------%@",mo.cell,mo.cells);
//        [_allCell addObject:mo];
    
//    }
    KnowledgeModel *model = [KnowledgeModel new];
    model = _allGroup[section];
    return model.groups.count;
//    NSLog(@"%@",_allGroups);
//    return 0;
//    NSLog(@"_allCell,count  = %ld-->%@",section,_allCell[section]);
//    return _allCell.count;
    //cellArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
//    KnowledgeModel * model = _allCell[indexPath.row];
//    cell.textLabel.text = model.cell;
    KnowledgeModel *model = [KnowledgeModel new];
    model = _allGroup[indexPath.section];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in model.groups) {
        NSString *cellNeme = dic[@"cell"];
        [array addObject:cellNeme];
    }
    cell.textLabel.text = array[indexPath.row];
      return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KnowTitleViewController *knowTitleVC=[[KnowTitleViewController alloc]init];
//    KnowledgeModel * model = _allCell[indexPath.row];
//    knowTitleVC.titleArray = model.cells;
    KnowledgeModel *model = [KnowledgeModel new];
    model = _allGroup[indexPath.section];
    NSMutableArray *arrays = [NSMutableArray array];
    NSMutableArray *titleArray = [NSMutableArray array];
    for (NSDictionary *dic in model.groups) {
        NSString *cellName = dic[@"cell"];
        NSArray *array = dic[@"cells"];
        [arrays addObject:array];
        [titleArray addObject:cellName];
    }
    knowTitleVC.titleName = titleArray[indexPath.row];
    knowTitleVC.titleArray = arrays[indexPath.row];
    
    [self.navigationController pushViewController:knowTitleVC animated:YES];
    
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
