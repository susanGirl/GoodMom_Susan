//
//  MyTopicCell.m
//  GD_GoodMom
//
//  Created by 80time on 16/6/6.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "MyTopicCell.h"
#import "NSDate+HFExtension.h"


// 帖子发表日期label宽度
#define kTopicPublishDateLabelWidth 120
// 控件间间隙
#define kMargin 5

@interface MyTopicCell()
// 帖子内容
@property (weak, nonatomic) IBOutlet UILabel *topicTextLabel;
// 帖子发表时间
@property (weak, nonatomic) IBOutlet UILabel *topicPublishDateLabel;

@end


@implementation MyTopicCell

- (void)setTopic:(Topic *)topic {
    
    if (_topic != topic) {
        _topic = nil;
        _topic = topic;
        
        _topicTextLabel.text = _topic.text;
        
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
                    _topicPublishDateLabel.text = [NSString stringWithFormat:@"%ld小时前", cmps.hour];
                }else if (cmps.minute >= 1) {
                    // 1小时 > 时间差距 >= 1分钟
                    _topicPublishDateLabel.text = [NSString stringWithFormat:@"%ld分钟前", cmps.minute];
                }else {
                    // 1分钟 > 时间差距
                    _topicPublishDateLabel.text = @"刚刚";
                }
            } else if (self.topic.creatAt.isYesterday) {
                // 昨天
                fmt.dateFormat = @"昨天 HH:mm:ss";
                _topicPublishDateLabel.text = [fmt stringFromDate:self.topic.creatAt];
            } else {
                // 其他
                fmt.dateFormat = @"MM-dd HH:mm:ss";
                _topicPublishDateLabel.text = [fmt stringFromDate:self.topic.creatAt];
            }
        }else {
            // 非今年
            _topicPublishDateLabel.text = [NSString stringWithFormat:@"%@", self.topic.creatAt];
        }
    
        
        CGRect frame = _topicTextLabel.frame;
        frame.size.height = [[self class] textHeight:topic];
        frame.size.width = kScreenW - kTopicPublishDateLabelWidth - 3 * kMargin;
        _topicTextLabel.frame = frame;
    
    }
}

+ (CGFloat)textHeight:(Topic *)topic {
    
    CGFloat textHeight = [topic.text boundingRectWithSize:CGSizeMake(kScreenW - kTopicPublishDateLabelWidth - 3 * kMargin, 10000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    return textHeight;
}
+ (CGFloat)cellHeight:(Topic *)topic {
    
    CGFloat cellHeight = [[self class] textHeight:topic];
    return cellHeight + 4 * kMargin;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
