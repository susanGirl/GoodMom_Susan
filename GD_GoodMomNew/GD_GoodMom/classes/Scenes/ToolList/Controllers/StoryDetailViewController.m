//
//  StoryDetailViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/27.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "StoryDetailViewController.h"
#import "StoryDetailCell.h"

@interface StoryDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

///故事段落数组
@property(nonatomic,strong)NSMutableArray *detailArray;
@property(nonatomic,strong)UITableView *tableView;

@end

static NSString *const storyDetailCellID = @"storyDetailCellID";

@implementation StoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"8.jpg"]];
    [self.view addSubview:imageView];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height) style:(UITableViewStyleGrouped)];
    
    ///根据上以页面传过来的model赋值title
    self.title = _story.title;
    //根据上一个页面传过来的model解析detail
    [self lyricsWithLyricString:_story.detail];
    //代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //注册当前页面使用的cell
    [self.tableView registerNib:[UINib nibWithNibName:@"StoryDetailCell" bundle:nil] forCellReuseIdentifier:storyDetailCellID];
    
    [self.view bringSubviewToFront:_tableView];
    [self.view addSubview:self.tableView];
    ///去掉横线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
///数组懒加载
- (NSMutableArray *)detailArray{
    if (!_detailArray) {
        _detailArray = [NSMutableArray array];
    }
    return _detailArray;
}

///故事段落数组
- (NSArray *)lyricsWithLyricString:(NSString *)lyricString{
    
    //每次解析之前，先将数组清空
    [self.detailArray removeAllObjects];
    //解析故事遇到回车就分解
    NSArray *allRowsLyric = [lyricString componentsSeparatedByString:@"\n"];
    for (NSString *string in allRowsLyric) {//解析数组得到的是字符串，赋值给model的detailStr
        detailModel *detail = [detailModel new];
        detail.detailStr = string;///将数组中的字符串赋值给当前页面model的属性detailStr
        [_detailArray addObject:detail];
        
    }
    
    NSLog(@"_detailArray%@",_detailArray[0]);
    return _detailArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"_detailArray.count = %ld",_detailArray.count);
    return _detailArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ////cell使用的是当前页面的cell
    StoryDetailCell *cell = [self.tableView dequeueReusableCellWithIdentifier:storyDetailCellID forIndexPath:indexPath];
    
    NSLog(@"_detailArray[indexPath.row] = %@",_detailArray[indexPath.row]);
    //model使用的是当前页面的model
    detailModel *detail =_detailArray[indexPath.row];
    //使用cell的控件，将model上对应的值赋值给cell控件
    if (detail != nil) {
        cell.detail = detail;
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //
   detailModel *detail =_detailArray[indexPath.row];
    NSLog(@"%f",[StoryDetailCell cellHeightWith:detail]);
    return [StoryDetailCell cellHeightWith:detail];
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
