//
//  UserViewController.m
//  Douban
//
//  Created by lanou3g on 16/5/4.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "UserViewController.h"
#import "LoginViewController.h"
#import "FileHandle.h"
#import <UIImageView+WebCache.h>
#import "MeTableViewController.h"
#import "TTConst.h"
#import "AboutViewController.h"
#import "pregnancyViewController.h"
#import "User.h"
#import <AVOSCloud/AVOSCloud.h>
#import "CollectionViewController.h"
#import "MyTopicViewController.h"

@interface UserViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;  //头像
@property (weak, nonatomic) IBOutlet UIView *contentVIew;
@property (nonatomic, copy) NSArray *items;
@property(nonatomic,strong)NSString *currentSkinModel;//当前皮肤模式
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.items = @[@"我的帖子",  @"我的收藏",@"怀孕周期", @"设置"];
    self.navigationItem.title = @"我的页面";
    self.navigationController.navigationBar.backgroundColor = [UIColor magentaColor];
    self.tableView.backgroundColor = kGlobalBackgroudColor;

#pragma mark----添加注销按钮----------
    
    NSString *title = nil;
    
    if ([FileHandle getUserInfo][@"loginState"] == [NSNumber numberWithBool:YES]) {
        // 如果处于登录状态则将按钮标题改为“注销”
        title = @"注销";
        _userNameLabel.text = [FileHandle getUserInfo].userName;
        
    }else{
        
        title = @"登录";
        _userNameLabel.text = @"未登录";
        
    }
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    self.navigationItem.rightBarButtonItem = cancelButton;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    if ([AVUser currentUser] && [cancelButton.title isEqualToString:@"注销"]) {
        AVFile *avatarFile = [AVFile fileWithURL:[AVUser currentUser][@"avatar"]];
        // 获取头像的缩略图
        [avatarFile getThumbnail:YES width:70 height:70 withBlock:^(UIImage *image, NSError *error) {
            _avatarImageView.image = image;
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateSkinModel) name:SkinModelDidChangedNotification  object:nil];
    [self updateSkinModel];

}

#pragma mark--private Method ----更新皮肤模式，接到模式切换的通知后会调用此方法
-(void)updateSkinModel{

    self.currentSkinModel = [[NSUserDefaults standardUserDefaults]stringForKey:CurrentSkinModelKey];
    if ([self.currentSkinModel isEqualToString:NightSkinModelValue]) {
        self.tableView.backgroundColor = [UIColor blackColor];
        self.contentVIew.backgroundColor = [UIColor grayColor];
    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
    }else{
   
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        self.contentVIew.backgroundColor = [UIColor whiteColor];
    }
}
/**
 * 点击注销按钮执行此方法
 * @param BarButton
 */
- (void)cancel:(UIBarButtonItem *)barButton{
    
    __weak UserViewController *userVC = self;
    
    if ([barButton.title isEqualToString:@"注销"]) {
        
        // 移除本地存储的用户信息
        [FileHandle removeUserInfo];
        _userNameLabel.text = @"未登录";
        // 设置当前用户登录状态为未登录
        [[AVUser currentUser] setObject:[NSNumber numberWithBool:NO] forKey:@"loginState"];
    
        // 存储到服务器
        [[AVUser currentUser] saveInBackground];
        barButton.title = @"登录";
        _avatarImageView.image = [UIImage imageNamed:@"woman.png"];
    }
    else{
        
        LoginViewController *loginVC = [LoginViewController new];
        
        // 接收登录页面传过来的用户信息
        loginVC.block = ^(User *user) {
            _userNameLabel.text = user.userName;
            barButton.title = @"注销";
            AVFile *avatarFile = [AVFile fileWithURL:[AVUser currentUser][@"avatar"]];
            // 获取头像的缩略图
            [avatarFile getThumbnail:YES width:70 height:70 withBlock:^(UIImage *image, NSError *error) {
                _avatarImageView.image = image;
            }];
            
            if (_avatarImageView.image == nil) {
                _avatarImageView.image = [UIImage imageNamed:@"woman.png"];
            }
        };
        [userVC presentViewController:loginVC animated:YES completion:nil];
    }
 }

/**
 * 点击头视图执行此方法
 */
- (IBAction)tapHeaderVIew:(id)sender {

    LoginViewController *logVC = [LoginViewController new];
    [self presentViewController:logVC animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _items[indexPath.row];
    
    
//    if ([self.currentSkinModel isEqualToString:NightSkinModelValue]) {//夜间模式
//        cell.backgroundColor = [UIColor colorWithRed:35/255.0 green:32/255.0 blue:36/255.0 alpha:1.0];
//        cell.textLabel.textColor =  [UIColor colorWithRed:111/255.0 green:109/255.0 blue:112/255.0 alpha:1.0];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//     
//    } else {//夜间模式
//        cell.backgroundColor =[UIColor whiteColor];
//        cell.textLabel.textColor = [UIColor blackColor];
//        cell.selectionStyle = UITableViewCellSelectionStyleGray;
//   
//    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MyTopicViewController *myTopicVC = [MyTopicViewController new];
        myTopicVC.theTitle = self.items[indexPath.row];
        [self.navigationController pushViewController:myTopicVC animated:YES];
    }
    if (indexPath.row == 1) {
        
        CollectionViewController *collectionVC = [CollectionViewController new];
        collectionVC.theTitle = self.items[indexPath.row];
        [self.navigationController pushViewController:collectionVC animated:YES];
    }

    if (indexPath.row == 2) {
    
        pregnancyViewController *preVC = [pregnancyViewController new];
        [self.navigationController pushViewController:preVC animated:YES];
        
        
    }
    
    if (indexPath.row == 3) {
      MeTableViewController *meVC = [MeTableViewController new];
        meVC.content = self.userNameLabel.text;
        [self.navigationController pushViewController:meVC animated:YES];
    }

    
    
    
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
