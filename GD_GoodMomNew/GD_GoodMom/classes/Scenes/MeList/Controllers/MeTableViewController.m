//
//  MeTableViewController.m
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "MeTableViewController.h"
#import <SDImageCache.h>
#import <SVProgressHUD.h>
#import "TTConst.h"
#import "AboutViewController.h"
#import "PersonalInformationViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "SendFeedbackViewController.h"
@interface MeTableViewController ()

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, weak) UISwitch *changeSkinSwitch;
@property (nonatomic, weak) UISwitch *shakeCanChangeSkinSwitch;
@property (nonatomic, weak) UISwitch *imageDownLoadModeSwitch;
@property (nonatomic, assign) CGFloat cacheSize;
@property (nonatomic, copy) NSString *currentSkinModel;//夜间模式

@property(nonatomic,strong)UILabel *nameLabel;

@end

CGFloat const footViewHeight = 30;

@implementation MeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    [self caculateCacheSize];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:91/255.0 blue:197/255.0 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(self.navigationController.navigationBar.frame) + 30, 0, 0, 0);
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //通知中心
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSkinModel) name:SkinModelDidChangedNotification object:nil];
    [self updateSkinModel];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除观察者
}

#pragma mark 更新皮肤模式 接到模式切换的通知后会调用此方法
-(void)updateSkinModel {
    self.currentSkinModel = [[NSUserDefaults standardUserDefaults] stringForKey:CurrentSkinModelKey];
    if ([self.currentSkinModel isEqualToString:NightSkinModelValue]) {
        self.tableView.backgroundColor = [UIColor blackColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {//日间模式
//        self.tableView.backgroundColor = [UIColor colorWithRed:255/255.0 green:91/255.0 blue:197/255.0 alpha:1.0];
        self.tableView.backgroundColor =  kGlobalBackgroudColor;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    [self.tableView reloadData];
}

-(void)caculateCacheSize {
    float imageCache = [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"data.sqlite"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float sqliteCache = [fileManager attributesOfItemAtPath:path error:nil].fileSize/1024.0/1024.0;
    self.cacheSize = imageCache + sqliteCache;
}

#pragma mark -UITableViewDataSource 返回tableView有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

#pragma mark -UITableViewDataSource 返回tableView每一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 1;
    else if(section == 1) return 2;
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return footViewHeight;
}

#pragma mark -UITableViewDataSource 返回indexPath对应的cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return 100;
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] init];
    footView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, footViewHeight);
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1);
    [footView addSubview:lineView1];
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.frame = CGRectMake(0, footViewHeight - 1, [UIScreen mainScreen].bounds.size.width, 1);
    [footView addSubview:lineView2];
    if ([self.currentSkinModel isEqualToString:DaySkinModelValue]) {//日间模式
        footView.backgroundColor = kGlobalBackgroudColor;
        lineView1.backgroundColor = kGlobalBackgroudColor;
        lineView2.backgroundColor = kGlobalBackgroudColor;
    } else {
        footView.backgroundColor = [UIColor blackColor];
        lineView1.backgroundColor = [UIColor blackColor];
        lineView2.backgroundColor = [UIColor blackColor];
    }
    if (section==2) {
        [lineView2 removeFromSuperview];
    }
    return footView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    if(indexPath.section == 0) {
        CGFloat cellHeight = 100;
        CGFloat margin = 10;
        CGFloat kScreenWidth = [UIScreen mainScreen].bounds.size.width;
        
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1);
        [cell addSubview:lineView];
        
        UIImageView *avatarImageView = [[UIImageView alloc] init];
        avatarImageView.frame =CGRectMake(margin, margin, cellHeight - 2*margin, cellHeight - 2*margin);
        AVFile *avatarFile = [AVFile fileWithURL:[AVUser currentUser][@"avatar"]];
        // 获取头像的缩略图
        [avatarFile getThumbnail:YES width:70 height:70 withBlock:^(UIImage *image, NSError *error) {
            avatarImageView.image = image;
        }];
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width * 0.5;
        avatarImageView.layer.masksToBounds = YES;
        [cell addSubview:avatarImageView];
        UILabel *nameLabel = [[UILabel alloc] init];
        self.nameLabel  = nameLabel;
        //属性传值
        self.nameLabel.text  = self.content;
        CGFloat nameLabelHeight = 21.5;
//        nameLabel.font = [UIFont systemFontOfSize:18];
#pragma mark--字体加粗
        nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
        if ([self.currentSkinModel isEqualToString:DaySkinModelValue]) {//日间模式
            nameLabel.textColor = [UIColor colorWithRed:255/255.0 green:91/255.0 blue:197/255.0 alpha:1.0];
            lineView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        } else {
            nameLabel.textColor = [UIColor grayColor];
            lineView.backgroundColor = [UIColor blackColor];
        }
        nameLabel.frame = CGRectMake(CGRectGetMaxX(avatarImageView.frame) + margin + 60, avatarImageView.frame.origin.y +avatarImageView.frame.size.height*0.5 - 10, kScreenWidth - 3*margin -avatarImageView.frame.size.width, nameLabelHeight);
        [cell addSubview:nameLabel];
        
        UILabel *contentLabel = [[UILabel alloc] init];
        CGFloat contentLabelHeight = 17.5;
        contentLabel.text = [[NSUserDefaults standardUserDefaults] stringForKey:UserSignatureKey];

        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.textColor = [UIColor grayColor];
        contentLabel.frame = CGRectMake(CGRectGetMaxX(avatarImageView.frame) + margin, avatarImageView.frame.origin.y +avatarImageView.frame.size.height*0.5+0.5*margin, kScreenWidth - 3*margin -avatarImageView.frame.size.width, contentLabelHeight);
        contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [cell addSubview:contentLabel];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    else if (indexPath.section == 1) {
       if (indexPath.row == 0) {
                cell.textLabel.text = @"👶夜间模式";
                if (cell.accessoryView == nil) {
                    UISwitch *changeSkinSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 51, 31)];
                    self.changeSkinSwitch = changeSkinSwitch;
                    [changeSkinSwitch addTarget:self action:@selector(switchDidChange:) forControlEvents:UIControlEventValueChanged];
                    cell.accessoryView = changeSkinSwitch;
                }
        }
        else if (indexPath.row == 1) {
                cell.textLabel.text = @"👶清除缓存";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f MB",self.cacheSize];
            }
        } else if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"👶反馈";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else if(indexPath.row == 1) {
                cell.textLabel.text = @"👶关于";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
    }
    
    if ([self.currentSkinModel isEqualToString:NightSkinModelValue]) {//夜间模式
        cell.backgroundColor = [UIColor colorWithRed:35/255.0 green:32/255.0 blue:36/255.0 alpha:1.0];
        cell.textLabel.textColor =  [UIColor colorWithRed:111/255.0 green:109/255.0 blue:112/255.0 alpha:1.0];
        cell.textLabel.font =   [UIFont fontWithName:@"Helvetica-Bold" size:20];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.changeSkinSwitch.on = YES;
    } else {//日间
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font =   [UIFont fontWithName:@"Helvetica-Bold" size:20];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        self.changeSkinSwitch.on = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
#pragma mark----清除缓存------
    if (indexPath.section == 1 && indexPath.row == 1) {
        [SVProgressHUD show];
        [[SDImageCache sharedImageCache] clearDisk];
        BOOL file = [AVFile clearAllCachedFiles];
        file = YES;//清除所有缓存
        [SVProgressHUD showSuccessWithStatus:@"缓存清除完毕!"];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"0.0MB"];
    }else if (indexPath.section == 2 && indexPath.row == 1){
        AboutViewController *aboutVC  = [AboutViewController new];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }else if (indexPath.section == 0 && indexPath.row == 0){
        
        PersonalInformationViewController *personalVC = [PersonalInformationViewController new];
        personalVC.hidesBottomBarWhenPushed =  YES;
        personalVC.content = self.nameLabel.text;
        [self.navigationController pushViewController:personalVC animated:YES];
        
    }else if(indexPath.section == 2 && indexPath.row == 0){
        SendFeedbackViewController *sendVC = [SendFeedbackViewController new];
#pragma mark---当push到下一个控制器的时候，隐藏tabbar
        sendVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:sendVC animated:YES];
    }
}

-(void)switchDidChange:(UISwitch *)theSwitch {
    if (theSwitch == self.changeSkinSwitch) {
        if (theSwitch.on == YES) {//切换至夜间模式
            [[NSUserDefaults standardUserDefaults] setObject:NightSkinModelValue forKey:CurrentSkinModelKey];
        } else {
            [[NSUserDefaults standardUserDefaults] setObject:DaySkinModelValue forKey:CurrentSkinModelKey];
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:SkinModelDidChangedNotification object:self];
    }
}







@end
