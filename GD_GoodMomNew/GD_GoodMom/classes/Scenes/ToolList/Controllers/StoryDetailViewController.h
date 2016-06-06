//
//  StoryDetailViewController.h
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/27.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryModel.h"
#import "DetailModel.h"
@interface StoryDetailViewController : UIViewController
@property(nonatomic,strong)StoryModel *story;///前一个页面传值需要的model
@property(nonatomic,strong)detailModel *detail;///当前页面显示内容的model
@end
