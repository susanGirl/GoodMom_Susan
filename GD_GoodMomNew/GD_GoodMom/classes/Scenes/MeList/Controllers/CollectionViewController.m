//
//  CollectionViewController.m
//  GD_GoodMom
//
//  Created by 80time on 16/6/4.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "CollectionViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface CollectionViewController ()

// 所有收藏的帖子
@property (strong, nonatomic) NSMutableArray *collectionTopics;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.theTitle;
    self.tableView.separatorStyle = UITableViewCellFocusStyleDefault;
    
    // 获取所有收藏的帖子
    for (NSString *objectId in [AVUser currentUser][@"collectionTopics"]) {
        AVQuery *queryTopic = [AVQuery queryWithClassName:@"Topic"];
        AVObject *topic = [queryTopic getObjectWithId:objectId];
        [self.collectionTopics addObject:topic];
    }
}

- (NSMutableArray *)collectionTopics {
    if (!_collectionTopics) {
        _collectionTopics = [NSMutableArray array];
    }
    return _collectionTopics;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.collectionTopics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    
    AVObject *topic = self.collectionTopics[indexPath.row];
    cell.textLabel.text = topic[@"text"];
    cell.backgroundColor = kGlobalBackgroudColor;
    cell.separatorInset = UIEdgeInsetsMake(1, 1, -1, 1);
    return cell;
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
