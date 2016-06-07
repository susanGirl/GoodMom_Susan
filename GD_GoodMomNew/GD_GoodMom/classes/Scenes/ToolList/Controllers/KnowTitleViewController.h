//
//  KnowTitleViewController.h
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/3.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KnowTitleModel.h"
@interface KnowTitleViewController : UITableViewController
//上一页面传递过来的数组【题目】
@property(nonatomic,strong)NSArray *titleArray;
//标题
@property(nonatomic,strong)NSString *titleName;
//model
@property(nonatomic,strong)KnowTitleModel *knowTitle;


@end
