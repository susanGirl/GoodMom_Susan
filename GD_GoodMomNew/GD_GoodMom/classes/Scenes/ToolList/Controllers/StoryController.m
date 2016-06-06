//
//  StoryController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "StoryController.h"

@interface StoryController ()

///所有故事的数组
@property(nonatomic,strong)NSMutableArray *storyArray;

@end
static NSString *const storyCellID = @"storyCellID";
@implementation StoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    ///返回按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"back1" heightImage:@"Unknown" targe:self action:@selector(backAction)];
    self.navigationItem.title = @"故事会";
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"StoryCell" bundle:nil] forCellReuseIdentifier:storyCellID];
    
    //解析数据
    [self dataWithPlist];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

///解析数据
- (void)dataWithPlist{
    //获取本地数据地址
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Story.plist" ofType:nil];
    //解析数据
    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:path];
    NSLog(@"array = %@",array);
    self.storyArray = [NSMutableArray array].mutableCopy;
    for (NSDictionary *dic in array) {
        StoryModel *story = [StoryModel storyModelWithDictionary:dic];
        NSLog(@"story = %@",story);
        [_storyArray addObject:story];
        NSLog(@"_storyArray = %@",_storyArray);
    }
    
}


///返回按钮事件
- (void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
    return _storyArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryCell *cell = [tableView dequeueReusableCellWithIdentifier:storyCellID forIndexPath:indexPath];
    StoryModel *story = _storyArray[indexPath.row];
    cell.story =story;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StoryDetailViewController *storyDetailVC = [StoryDetailViewController new];
    StoryModel *story = _storyArray[indexPath.row];
    storyDetailVC.story = story;
    NSLog(@"story == %@",story);
    [self.navigationController pushViewController:storyDetailVC animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 149;
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
