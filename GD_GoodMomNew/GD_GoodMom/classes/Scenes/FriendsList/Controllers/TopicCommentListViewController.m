//
//  TopicCommentListViewController.m
//  GD_GoodMom
//
//  Created by 80time on 16/6/1.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "TopicCommentListViewController.h"
#import "TopicCell.h"
#import "TopicCommentCell.h"
#import <AVOSCloud/AVOSCloud.h>
#import "Comment.h"
#import <UMSocial.h>


// tableView.ContentView内边距
// 显示内容区域距离屏幕顶部偏移量
#define kTopOffset 50
// 显示内容区域距离屏幕底部偏移量
#define kBottomOffset 0

@interface TopicCommentListViewController ()<UITableViewDelegate, UITableViewDataSource, UMSocialUIDelegate>
// 帖子内容和评论内容显示区域
@property (weak, nonatomic) IBOutlet UITableView *topicCommentTableView;
// 底部工具栏底部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
// 评论控件
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;
// 底部工具条背景视图
@property (weak, nonatomic) IBOutlet UIView *toolBackgroundView;
// 存放帖子的所有评论的数组
@property (strong, nonatomic) NSMutableArray *commentsArray;
// 评论区cell高度
@property (assign, nonatomic) CGFloat commentCellHeight;
@end


// topicCell标识符
static NSString *const topicCellID = @"topicCell";
// topicCommentCell标识符
static NSString *const topicCommentCellID = @"topicCommentCell";

@implementation TopicCommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 绘图
    [self setupTableView];
    
}

#pragma mark -- 绘图 --
- (void)setupTableView {
    
    // 隐藏tabbar
    self.tabBarController.tabBar.hidden = YES;
    
    // 设置底部工具条背景视图颜色
    self.toolBackgroundView.backgroundColor = kGlobalBackgroudColor;
    
    // 设置控制器标题
    self.title = @"评论";
    // 设置控制器导航栏右侧按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"mainCellShare" heightImage:@"mainCellShareClick" targe:self action:@selector(shareAction)];
    
    // 注册观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // cell的高度设置
    self.topicCommentTableView.estimatedRowHeight = 44;
    self.topicCommentTableView.rowHeight = UITableViewAutomaticDimension;
    
    // 背景色
    self.topicCommentTableView.backgroundColor = kGlobalBackgroudColor;
    
    // 注册Topiccell
    [self.topicCommentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TopicCell class]) bundle:nil] forCellReuseIdentifier:topicCellID];
    
    // 注册TopicCommentCell
    [self.topicCommentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TopicCommentCell class]) bundle:nil] forCellReuseIdentifier:topicCommentCellID];
    
    // 取消分割线
    self.topicCommentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.topicCommentTableView.contentInset = UIEdgeInsetsMake(kTopOffset, 0, kBottomOffset, 0);
    
    // 视图出现时，刷新表格
    [self.topicCommentTableView reloadData];
}

#pragma mark -- 分享帖子(友盟分享） --
- (void)shareAction {
    
    AVFile *imgFile = [AVFile fileWithURL:self.topic.images[0]];
    NSData *data = [imgFile getData];
    UIImage *img = [UIImage imageWithData:data];
    
    
    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
//    [UMSocialData defaultData].extConfig.title = @"分享到";
//    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
//    [UMSocialData defaultData].extConfig.qqData.title = @"QQ分享title";
//    [UMSocialData defaultData].extConfig.qzoneData.url = @"http://baidu.com";
//    [UMSocialData defaultData].extConfig.qzoneData.title = @"Qzone分享title";
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://baidu.com";
//    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"微信好友title";
//    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://baidu.com";
//    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"微信朋友圈title";
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5750db84e0f55a2afc00017a"
                                      shareText:self.topic.text
                                     shareImage:img
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
                                       delegate:self];
    
    // 1. 支持分享编辑页和授权页面横屏，必须要在出现列表页面前设置:
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskLandscape];
}

// -- 实现回调方法 --
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }else {
        NSLog(@"%d", response.responseCode);
    }
    
    [UMSocialData openLog:YES];
}


#pragma mark -- 存放帖子的所有评论的数组 --
- (NSMutableArray *)commentsArray {
    if (!_commentsArray) {
        _commentsArray = [NSMutableArray array];
        
        for (NSDictionary *modelDict in self.topic.commentsArray) {
            Comment *comment = [Comment new];
            [comment setValuesForKeysWithDictionary:modelDict];
            [_commentsArray addObject:comment];
        }
    }
    return _commentsArray;
}

- (void)keyboardWillChangeFrame:(NSNotification *)note {
    // 键盘显示/隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 修改底部约束
    self.bottomSpace.constant = kScreenH - frame.origin.y;
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark -- 发表评论 --
- (IBAction)publishCommentAction:(id)sender {
    
    __weak TopicCommentListViewController *weakTopicCommentListVC = self;
    
    // 根据帖子id从服务器查找该帖子
    AVObject *currentTopic = [Topic objectWithClassName:@"Topic" objectId:self.topic.objectId];
    
    // 更新服务器数据
    [currentTopic fetchIfNeededInBackgroundWithBlock:^(AVObject *object, NSError *error) {

        // 将评论内容赋值给帖子对象
        NSMutableDictionary *comment = [NSMutableDictionary dictionary];
        [comment setObject:self.commentTextField.text forKey:@"content"];
        [comment setObject:[AVUser currentUser].username forKey:@"username"];
        [comment setObject:[AVUser currentUser][@"avatar"] forKey:@"avatar"];
        [object[@"commentsArray"] addObject:comment];
        [object setObject:object[@"commentsArray"] forKey:@"commentsArray"];
        
        // 获取评论数量,并赋值给帖子对象
        NSArray *commentsArray = object[@"commentsArray"];
        [object setObject:[NSNumber numberWithInteger:commentsArray.count] forKey:@"commentCount"];
        
        // 提示框
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 发表评论成功后返回到上一页面
            [weakTopicCommentListVC.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:okAction];
        
        if (!error) {
            
            // 让本地数据与云端保持一致
            currentTopic.fetchWhenSave = true;
            [currentTopic saveInBackground];
            
            alert.message = @"评论成功!";
            // 弹出提示框
            [weakTopicCommentListVC presentViewController:alert animated:YES completion:nil];
            
            // 使用通知中心刷新上个页面
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateComments" object:nil];
            
        } else {
            alert.message = [NSString stringWithFormat:@"评论失败，错误原因%@", error];
            // 弹出提示框
            [weakTopicCommentListVC presentViewController:alert animated:YES completion:nil];
        }
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    return self.commentsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        TopicCell *topicCell = [tableView dequeueReusableCellWithIdentifier:topicCellID forIndexPath:indexPath];
        topicCell.topic = self.topic;
        topicCell.collectionButton.hidden = YES;
        topicCell.commentButton.hidden = YES;
        return topicCell;
    }
    
    // 评论区
    TopicCommentCell *topicCommentCell = [tableView dequeueReusableCellWithIdentifier:topicCommentCellID forIndexPath:indexPath];
    
    // 倒序排列评论数组,让最新评论显示在最上面
    NSArray *reverseCommentsArray = [[self.commentsArray reverseObjectEnumerator] allObjects];
    
    // 赋值
    topicCommentCell.comment = reverseCommentsArray[indexPath.row];
    // 评论区cell高度
    self.commentCellHeight = topicCommentCell.calculateCellHeight;
    return topicCommentCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 开始滑动时，变成不可编辑状态
    [self.view endEditing:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return @"用户回帖";
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return self.cellHeight + kTopOffset - kBottomOffset;
    }
    return self.commentCellHeight;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 开始滑动时，变成不可编辑状态
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
