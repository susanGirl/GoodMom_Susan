//
//  MyTopicViewController.m
//  GD_GoodMom
//
//  Created by 80time on 16/6/6.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "MyTopicViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "MyTopicCell.h"
#import "Topic.h"

// tableView.ContentView内边距
// 显示内容区域距离屏幕顶部偏移量
#define kTopOffset 0
// 显示内容区域距离屏幕底部偏移量
#define kBottomOffset 0

@interface MyTopicViewController ()

@property (strong, nonatomic) NSMutableArray *myTopics;

@end

static NSString *const myTopicCellID = @"myTopic";

@implementation MyTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.theTitle;
    
    self.tableView.contentInset = UIEdgeInsetsMake(kTopOffset, 0, kBottomOffset, 0);
    
    // 取消系统分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyTopicCell class]) bundle:nil] forCellReuseIdentifier:myTopicCellID];
    
    // 获取所有我发的帖子
    AVQuery *queryTopic = [AVQuery queryWithClassName:@"Topic"];
    [queryTopic orderByDescending:@"createdAt"];
    [queryTopic whereKey:@"username" equalTo:[AVUser currentUser].username];
    
    for (AVObject *object in [queryTopic findObjects]) {
        Topic *topic = [Topic new];
        [topic setValuesForKeysWithDictionary:object[@"localData"]];
        [topic setValue:object.createdAt forKey:@"creatAt"]; // 发帖时间
        [self.myTopics addObject:topic];
    }
   
    [self.tableView reloadData];
}


- (NSMutableArray *)myTopics {
    if (!_myTopics) {
        _myTopics = [NSMutableArray array];
    }
    return _myTopics;
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

    return self.myTopics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:myTopicCellID forIndexPath:indexPath];
    Topic *topic = self.myTopics[indexPath.row];
    cell.topic = topic;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Topic *topic = self.myTopics[indexPath.row];
    return [MyTopicCell cellHeight:topic];
}
@end
