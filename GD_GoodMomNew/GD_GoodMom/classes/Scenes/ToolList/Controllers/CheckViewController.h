//
//  CheckViewController.h
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/27.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CheckBlock)(NSArray *array);

@interface CheckViewController : UIViewController
@property(nonatomic,strong)NoteModel *note;
@property(nonatomic,copy)CheckBlock block;


@end
