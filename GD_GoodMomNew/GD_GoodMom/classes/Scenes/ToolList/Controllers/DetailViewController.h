//
//  DetailViewController.h
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteModel.h"

typedef void(^DetailBlock)(NSArray *array);
@interface DetailViewController : UIViewController

@property(nonatomic,strong)NoteModel *note;

@property(nonatomic,copy)DetailBlock block;

@end
