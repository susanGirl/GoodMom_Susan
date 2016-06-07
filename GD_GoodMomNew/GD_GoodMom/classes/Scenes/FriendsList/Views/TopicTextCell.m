//
//  TopicCell.m
//  GD_GoodMom
//
//  Created by 80time on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "TopicTextCell.h"
#import "TopicCommentListViewController.h"
#import "NSDate+HFExtension.h"
#import <AVOSCloud/AVOSCloud.h>
#import "LoginViewController.h"

// 间距
#define kCellMargin 5
// 头像视图高度
#define kAvatarImageViewH 40
// 底部工具条高度
#define kToolViewH 20
// 帖子图片视图背景视图
#define kImgBackgroundViewW (kScreenW - 2 * kCellMargin)
#define kImgBackgroundViewH kImgBackgroundViewW

@interface TopicTextCell ()

// 用户头像
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
// 用户昵称
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
// 宝宝性别
@property (weak, nonatomic) IBOutlet UILabel *babyGenderLabel;
// 宝宝出生日期
@property (weak, nonatomic) IBOutlet UILabel *babyBirthdayLabel;
// 发帖时间
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
// 帖子文字内容
@property (weak, nonatomic) IBOutlet UILabel *topicTextLabel;
// 底部控件底部视图
@property (weak, nonatomic) IBOutlet UIView *bottomToolView;
// 有效图片数量
@property (assign, nonatomic) NSInteger imagesCount;



@property (strong, nonatomic) UIImage *theImage;


// 文本位置尺寸
@property (assign, nonatomic) CGRect textFrame;

@end



@implementation TopicTextCell

- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGRect frame = self.contentView.frame;
    
    frame.origin.x = kCellMargin;
    frame.size.width -= 2 * kCellMargin;
    frame.size.height -= kCellMargin;
    frame.origin.y += kCellMargin;
    self.backgroundColor = kGlobalBackgroudColor;
    self.contentView.frame = frame;
    self.contentView.backgroundColor = [UIColor whiteColor];
    
}

- (void)awakeFromNib {


}

#pragma mark -- 重写topic --

- (void)setTopic:(Topic *)topic {
    if (_topic != topic) {
        _topic = nil;
        _topic = topic;
        
        
        // 设置用户头像
        AVFile *file = [AVFile fileWithURL:self.topic.avatar];
        NSData *avatarData = [file getData];
        UIImage *avatarImage = [UIImage imageWithData:avatarData];
        self.avatarImageView.image = avatarImage;
        
        
        // 设置用户昵称
        self.usernameLabel.text = self.topic.username;
        
        // 设置发帖时间
        /**
         *  日期的最终显示格式
         *今年
         *  今天
         *      1分钟内：刚刚
         *      1小时内：xx分钟前
         *      其他：xx小时前
         *  昨天：昨天 18：56：35
         *非今年：2015-04-05 18：45：34
         */
        // 日期格式化类
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        // 设置日期格式
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        if (self.topic.creatAt.isThisYear) {
            // 今年
            if (self.topic.creatAt.isToday) {
                // 今天
                NSDateComponents *cmps = [[NSDate date] deltaFrom:self.topic.creatAt];
                if (cmps.hour >= 1) {
                    // 时间差距 >= 1小时
                    self.createdAtLabel.text = [NSString stringWithFormat:@"%ld小时前", cmps.hour];
                }else if (cmps.minute >= 1) {
                    // 1小时 > 时间差距 >= 1分钟
                    self.createdAtLabel.text = [NSString stringWithFormat:@"%ld分钟前", cmps.minute];
                }else {
                    // 1分钟 > 时间差距
                    self.createdAtLabel.text = @"刚刚";
                }
            } else if (self.topic.creatAt.isYesterday) {
                // 昨天
                fmt.dateFormat = @"昨天 HH:mm:ss";
                self.createdAtLabel.text = [fmt stringFromDate:self.topic.creatAt];
            } else {
                // 其他
                fmt.dateFormat = @"MM-dd HH:mm:ss";
                self.createdAtLabel.text = [fmt stringFromDate:self.topic.creatAt];
            }
        }else {
            // 非今年
            self.createdAtLabel.text = [NSString stringWithFormat:@"%@", self.topic.creatAt];
        }
        
        
        // 帖子文字内容
        self.topicTextLabel.text = topic.text;
        _topicTextLabel.numberOfLines = 0;
        CGFloat topicHeight = [[self class] calculateTextHeight:_topic];
        CGRect frame = self.topicTextLabel.frame;
        frame.size.height = topicHeight;
        _topicTextLabel.frame = frame;
        

        // 设置收藏帖子的人数
        [self setupButtonTitle:self.collectionButton count:self.topic.collectionCount placeholder:@"收藏"];
        // 设置评论帖子的人数
        [self setupButtonTitle:self.commentButton count:self.topic.commentCount placeholder:@"评论"];
        
        // 宝宝性别
        self.babyGenderLabel.text = self.topic.babyGender;
        
        AVQuery *query = [AVQuery queryWithClassName:@"Topic"];
        [query whereKey:@"objectId" equalTo:self.topic.objectId];
        
        // 到服务器查找该帖子
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            // 获取帖子
            Topic *currentTopic = objects[0];
            
            if ([[AVUser currentUser][@"collectionTopics"] containsObject:currentTopic.objectId]) {
                self.collectionButton.selected = YES;
            }else {
                self.collectionButton.selected = NO;
            }
        }];
    }
}

#pragma mark -- 设置底部按钮的标题 --
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder {
    
    if (count > 10000) {
        // 评论数量大于10000时
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

// 计算文本高度
+ (CGFloat)calculateTextHeight:(Topic *)topic {
    // 文本高度
    CGSize maxSize = CGSizeMake(kScreenW - 2 * kCellMargin , 10000);
    // 计算文本的高度
    CGFloat textH = [topic.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    return textH;
}

// 计算cell高度
+ (CGFloat)calculateCellHeight:(Topic *)topic {
    
    // cell的高度
    return [[self class] calculateTextHeight:topic]  + kAvatarImageViewH +  kToolViewH + 10 * kCellMargin;
}

#pragma mark -- 收藏帖子 --
- (IBAction)collectionTopicAction:(id)sender {
    
    if ([AVUser currentUser] && [[AVUser currentUser][@"loginState"] boolValue] == YES) {
        // 如果用户登录了才可以收藏
        
        UIButton *collectionButton = (UIButton *)sender;
        
        AVQuery *query = [AVQuery queryWithClassName:@"Topic"];
        [query whereKey:@"objectId" equalTo:self.topic.objectId];
        
        // 到服务器查找该帖子
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            // 获取帖子
            Topic *currentTopic = objects[0];
            
            // 获取帖子当前收藏数量
            NSInteger currentCollectionCount = [[[currentTopic objectForKey:@"localData"] objectForKey:@"collectionCount"] integerValue];
            
            // 提示框
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okAction];
            
            
            // 如果没有收藏该帖子，就开始收藏
            if (![[AVUser currentUser][@"collectionTopics"] containsObject:currentTopic.objectId]) {
                
                // 收藏数量加“1”
                currentCollectionCount += 1;
                
                // 将要收藏的帖子保存到当前用户的收藏列表中
                [[[AVUser currentUser] objectForKey:@"collectionTopics"] addObject:currentTopic.objectId];
                [[AVUser currentUser] setObject:[[AVUser currentUser] objectForKey:@"collectionTopics"] forKey:@"collectionTopics"];
                [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    
                    if (succeeded) {
                        // 提示收藏成功
                        alert.message = @"收藏成功!";
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
                        
                        // collectionButton改为选中状态
                        collectionButton.selected = YES;
                        
                    }else {
                        alert.message = [NSString stringWithFormat:@"收藏失败，失败原因:%@", error];
                    }
                }];
                
            } else {
                
                // 如果已经收藏了该帖子，就取消收藏
                
                // 收藏数量减“1”
                currentCollectionCount -= 1;
                
                // 将收藏的帖子保存到当前用户的收藏列表中
                [[[AVUser currentUser] objectForKey:@"collectionTopics"] removeObject:currentTopic.objectId];
                [[AVUser currentUser] setObject:[[AVUser currentUser] objectForKey:@"collectionTopics"] forKey:@"collectionTopics"];
                [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        // 提取取消收藏成功
                        alert.message = @"取消收藏成功!";
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
                        
                        // collectionButton改为未选中状态
                        collectionButton.selected = NO;
                        
                    } else {
                        alert.message = [NSString stringWithFormat:@"取消收藏失败，失败原因：%@", error];
                    }
                }];
            }
            
            // 设置最新收藏数量
            [currentTopic setObject:[NSNumber numberWithInteger:currentCollectionCount] forKey:@"collectionCount"];
            
            // 保存到服务器
            [currentTopic saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                if (succeeded) {
                    
                    // 改变帖子页面显示的收藏数量
                    [self updateCollectionCountShow:currentCollectionCount];
                    
                }else {
                    // 提示框
                    alert.message = [NSString stringWithFormat:@"收藏失败，错误码%@", error];
                    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
                }
            }];
            
        }];
    } else {
        // 如果没有用户登陆，即currentUser为空，则跳转到登陆页面
        LoginViewController *loginVC = [LoginViewController new];
        loginVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:loginVC animated:YES completion:nil];
    }
}

#pragma  mark -- 改变帖子页面显示的收藏数量 --
- (void)updateCollectionCountShow:(NSInteger) collectionCount {
    [self setupButtonTitle:self.collectionButton count:collectionCount placeholder:@"收藏"];
}
#pragma mark -- 评论帖子 --
- (IBAction)commentTopicAction:(id)sender {
 
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
