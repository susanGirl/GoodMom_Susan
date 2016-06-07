//
//  TopicCell.m
//  GD_GoodMom
//
//  Created by 80time on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "TopicCell.h"

// 间距
#define kCellMargin 5
// 帖子图片视图背景视图
#define kImgBackgroundViewW self.contentView.width
#define kImgBackgroundViewH (kImgBackgroundViewW * 3 / 4)

@interface TopicCell ()

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
// 帖子图片视图背景视图
@property (weak, nonatomic) IBOutlet UIView *imgBackgroundView;
// 有效图片数量
@property (assign, nonatomic) NSInteger imagesCount;



@property (strong, nonatomic) UIImage *theImage;


// 文本位置尺寸
@property (assign, nonatomic) CGRect textFrame;

@end



@implementation TopicCell

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
        NSDateFormatter *dateformatter = [NSDateFormatter new];
        NSTimeZone *timeZone = [NSTimeZone localTimeZone];
        [dateformatter setTimeZone:timeZone];
        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *createAtString =  [dateformatter stringFromDate:self.topic.creatAt];
        self.createdAtLabel.text = createAtString;
        
        // 帖子文字内容
        self.topicTextLabel.text = topic.text;
        
        // 帖子图片内容
        NSLog(@"%@", self.topic.images);
        
        // 有效图片数量
        __block NSInteger imagesCount = 0;
        
        for (int i = 0; i < self.topic.images.count; i++) {
            AVFile *imgFile = [AVFile fileWithURL:self.topic.images[i]];
            
            [imgFile getThumbnail:YES width:self.imgBackgroundView.width height:kImgBackgroundViewH withBlock:^(UIImage *image, NSError *error) {
                
                if (image) {
                    UIImageView *imgView = [[UIImageView alloc] init];
                    imgView.frame = CGRectMake(0, imagesCount * kImgBackgroundViewH, self.imgBackgroundView.width, kImgBackgroundViewH);
                    imgView.image = image;
                    [self.imgBackgroundView addSubview:imgView];
                    
                    // 有效图片加“1”
                    imagesCount += 1;
                    
                    self.imagesCount = imagesCount;
                }
                
            }];
            
            
            // ============ 另外一种获取图片的方法 =============
            //            [imgFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            //                UIImage *img = [UIImage imageWithData:data];
            //
            //                if (img) {
            //                    UIImageView *imgView = [[UIImageView alloc] init];
            //                    imgView.frame = CGRectMake(0, imagesCount * kImgBackgroundViewH, self.imgBackgroundView.width, kImgBackgroundViewH);
            //                    imgView.image = img;
            //                    [self.imgBackgroundView addSubview:imgView];
            //
            //                    // 有效图片加“1”
            //                    imagesCount += 1;
            //
            //                    self.imagesCount = imagesCount;
            //                }
            //                
            //            } progressBlock:^(NSInteger percentDone) {
            //                
            //            }];
            // ================================
        }

        // 设置收藏帖子的人数
        [self setupButtonTitle:self.collectionButton count:self.topic.collectionCount placeholder:@"收藏"];
        // 设置评论帖子的人数
        [self setupButtonTitle:self.commentButton count:self.topic.commentCount placeholder:@"评论"];
        // 宝宝性别
        self.babyGenderLabel.text = self.topic.babyGender;
#warning 计算宝宝年龄
        // 宝宝年龄
//        NSDate *currentDate = [NSDate date];
//        NSDateFormatter *fmt = [NSDateFormatter new];
//        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//        NSString *babyBirthday = self.topic.user.babyBirthday;
        // 当前时间 - 宝贝出生日期 = 宝宝年龄
        NSDate *babyBirthday = self.topic.babyBirthday;
        NSString *dateString = [dateformatter stringFromDate:babyBirthday];
        self.babyBirthdayLabel.text = dateString;

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

#pragma mark -- 设置Frame --
- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = kCellMargin;
    frame.size.width -= 2 * kCellMargin;
    frame.size.height -= kCellMargin;
    frame.origin.y += kCellMargin;
    [super setFrame:frame];
}

- (void)layoutSubviews {


    // -- 文本位置尺寸 --
    // 文本Y坐标
    self.topicTextLabel.y = CGRectGetMaxY(self.avatarImageView.frame) + kCellMargin;
    // 文本高度
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * kCellMargin , 10000);
    // 计算文本的高度
    CGFloat textH = [self.topic.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    self.topicTextLabel.height = textH;
    
    // -- 图片位置尺寸 --
    self.imgBackgroundView.y = self.topicTextLabel.y + self.topicTextLabel.height + kCellMargin;
    self.imgBackgroundView.height = kImgBackgroundViewH * self.imagesCount;
    
    // -- 底部控件底部视图位置尺寸 --
    self.bottomToolView.y = CGRectGetMaxY(self.imgBackgroundView.frame) + kCellMargin;
    
}

// 计算cell高度
- (CGFloat)calculateCellHeight {

    // cell的高度（包含文字时）
    return self.bottomToolView.y + 30 + kCellMargin;
    
}

#pragma mark -- 收藏帖子 --
- (IBAction)collectionTopicAction:(id)sender {
    
    UIButton *collectionButton = (UIButton *)sender;
    
    AVQuery *query = [AVQuery queryWithClassName:@"Topic"];
    [query whereKey:@"createdAt" equalTo:self.topic.creatAt];

    // 到服务器查找该帖子
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"%@", [objects[0] objectForKey:@"localData"]);
        // 获取帖子
        Topic *currentTopic = objects[0];
        // 获取帖子当前收藏数量
        NSInteger currentCollectionCount = [[[currentTopic objectForKey:@"localData"] objectForKey:@"collectionCount"] integerValue];
        
        // 提示框
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        
        if (collectionButton.selected == NO) {
            // 收藏数量加“1”
            currentCollectionCount += 1;
            // collectionButton改为选中状态
            collectionButton.selected = YES;
            // 提示收藏成功
            alert.message = @"收藏成功!";
        } else {
            // 收藏数量减“1”
            currentCollectionCount -= 1;
            // collectionButton改为选中状态
            collectionButton.selected = NO;
            // 提示取消收藏成功
            alert.message = @"取消收藏成功!";
        }

        // 设置最新收藏数量
        [currentTopic setObject:[NSNumber numberWithInteger:currentCollectionCount] forKey:@"collectionCount"];
        
        // 保存到服务器
        [currentTopic saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {

            if (succeeded) {
                
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
                
                // 改变帖子页面显示的收藏数量
                [self updateCollectionCountShow:currentCollectionCount];
                
            }else {
                // 提示框
                alert.message = [NSString stringWithFormat:@"收藏失败，错误码%@", error];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
            }
        }];
        
    }];
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
