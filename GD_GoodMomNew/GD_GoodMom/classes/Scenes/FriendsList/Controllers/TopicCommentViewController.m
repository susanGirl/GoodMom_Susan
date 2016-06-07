//
//  TopicCommentViewController.m
//  GD_GoodMom
//
//  Created by 80time on 16/5/30.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "TopicCommentViewController.h"
#import "TopicCell.h"
#import "TopicCommentCell.h"

@interface TopicCommentViewController ()

@end

// topicCell标识符
static NSString *const topicCellID = @"topicCell";
// topicCommentCell标识符
static NSString *const topicCommentCellID = @"topicCommentCell";

@implementation TopicCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 绘图
    [self setupTableView];

}

#pragma mark -- 绘图 --
- (void)setupTableView {
    // 注册Topiccell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TopicCell class]) bundle:nil] forCellReuseIdentifier:topicCellID];
    // 注册TopicCommentCell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TopicCommentCell class]) bundle:nil] forCellReuseIdentifier:topicCommentCellID];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        TopicCell *topicCell = [tableView dequeueReusableCellWithIdentifier:topicCellID forIndexPath:indexPath];
        topicCell.topic = self.topic;
        topicCell.collectionButton.hidden = YES;
        topicCell.commentButton.hidden = YES;
        self.cellHeight = [topicCell calculateCellHeight];
        return topicCell;
    }
    
    // 评论区
    TopicCommentCell *topicCommentCell = [tableView dequeueReusableCellWithIdentifier:topicCommentCellID forIndexPath:indexPath];
    

    return topicCommentCell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return @"用户回帖";
    }
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return self.cellHeight;
    }
    return 60;
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
