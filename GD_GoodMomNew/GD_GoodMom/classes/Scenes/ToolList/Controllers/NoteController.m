//
//  NoteController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "NoteController.h"


@interface NoteController ()<UITableViewDelegate,UITableViewDataSource>

///本地数据库
@property(nonatomic,strong)DBHandle *dbhandle;

@end
static NSString *const NoteCellID = @"NoteCellID";///cell标识符
@implementation NoteController
//懒加载数组
- (NSMutableArray *)noteArray{
    if (!_noteArray) {
        _noteArray = [NSMutableArray array];
    }
    return _noteArray;
}

#warning 没有调用查询数据库的方法
///视图将要加载的时候刷新数据
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"日记";
    ///返回按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"back1" heightImage:@"Unknown" targe:self action:@selector(backAction)];
   
    //进入编辑日记界面
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"addNote" heightImage:@"addNote_h" targe:self action:@selector(noteAction)];
    //代理
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //创建数据库
    _dbhandle = [DBHandle sharedDBManager];
    [_dbhandle openDB];
    [_dbhandle  createTable];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"NoteCell" bundle:nil] forCellReuseIdentifier:NoteCellID];
  
    //取出横线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
///返回按钮事件
- (void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}


//点击进入写作界面
- (void)noteAction{
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.block = ^(NSArray *array){
        _noteArray = array.mutableCopy;
        
    };
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source
///分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
///分区中的cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ///没有笔记的时候
    if (_noteArray.count == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"还有没有日记" message:@"点击右上角记录自己的心情吧~~~" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    return self.noteArray.count;
    
}

///cell的样式及内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NoteCell *cell = [tableView dequeueReusableCellWithIdentifier:NoteCellID forIndexPath:indexPath];
    NoteModel *note = _noteArray[indexPath.row];
    cell.note = note;
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(300)/225.0 green:arc4random_uniform(300)/225.0 blue:arc4random_uniform(300)/225.0 alpha:1.0];
    
    return cell;
}


///cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoteModel *note = _noteArray[indexPath.row];
    return [NoteCell cellHeightWith:note];
}


///是否可以编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

///编辑方式
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    ///删除
//    return UITableViewCellEditingStyleDelete;
//    
//}



///删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ///删除数据
        NoteModel *note = _noteArray[indexPath.row];
#warning 数据库删除
        [_dbhandle openDB];
        [_dbhandle deleteNoteWith:note.title];
        ///虽然数据库的数据删除了，但是目前的数组也应该删除一下数据，防止因为更新不及时造成的ui无法删除的问题
        [_noteArray removeObject:note];
       ///删除UI
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationLeft)];
        ///刷新数据
        [self.tableView reloadData];
        
        
    }
}


///选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CheckViewController *detailVC = [CheckViewController new];
    NoteModel *note = _noteArray[indexPath.row];
    detailVC.note = note;
    detailVC.block = ^(NSArray *array){
        self.noteArray = array.mutableCopy;
    };
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
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
