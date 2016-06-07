//
//  PersonalInformationViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/1.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "PersonalInformationViewController.h"
#import "PersonalInformationCell.h"
#import "LoginViewController.h"

@interface PersonalInformationViewController ()
@property (nonatomic, copy) NSString *currentSkinModel;//夜间模式
@property (strong,nonatomic) PersonalInformationCell *cell;
@end

static NSString *const identifier = @"cellID";
@implementation PersonalInformationViewController
- (void)viewDidLoad {
    [super viewDidLoad];
   //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"PersonalInformationCell" bundle:nil] forCellReuseIdentifier:identifier];
    //添加编辑按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:(UIBarButtonItemStylePlain) target:self action:@selector(edittingAction:)];
}

- (void)viewWillAppear:(BOOL)animated{
    //通知中心
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateSkinModel) name:SkinModelDidChangedNotification object:nil];
    [self updateSkinModel];
    

}
#pragma mark
-(void)updateSkinModel{
    self.currentSkinModel = [[NSUserDefaults standardUserDefaults] stringForKey:CurrentSkinModelKey];
    if ([self.currentSkinModel isEqualToString:NightSkinModelValue]) {
        self.tableView.backgroundColor =[UIColor colorWithRed:35/255.0 green:32/255.0 blue:36/255.0 alpha:1.0];
    } else {//日间模式
        self.tableView.backgroundColor = [UIColor whiteColor];
    }
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if ([self.currentSkinModel isEqualToString:DaySkinModelValue])  {
    [cell  updateToDaySkinMode];
    }else{
        [cell updateToNightSkinMode];
    }
    self.cell = cell;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.userNameLabel.text = self.content;
    User *user = [User new];
    cell.user = user;
    
 
    
    return cell;
}
#pragma mark--编辑按钮的响应方法
-(void)edittingAction:(UIBarButtonItem *)button{
    if ([button.title isEqualToString:@"编辑"]) {
       button.title = @"完成";
        self.cell.genderTF.userInteractionEnabled = YES;

    }else
    {
#pragma mark--对当前用户添加属性
        [[AVUser currentUser]saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [[AVUser currentUser]setObject:_cell.genderTF.text forKey:@"babyGender"];//宝宝性别
            [[AVUser currentUser]setObject:self.cell.userGender.text forKey:@"userGender"];//用户性别
            [[AVUser currentUser]setObject:_cell.birsthdayTF.text forKey:@"babybirthday"];//宝宝生日
            [[AVUser currentUser]setObject:_cell.hobbyTF.text forKey:@"babyHobby"];
            [[AVUser currentUser]saveInBackground];
        }];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 260;
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
