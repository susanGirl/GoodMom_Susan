//
//  CheckViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/27.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "CheckViewController.h"
#import "DBHandle.h"



@interface CheckViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextFiled;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
///暂时存储title
@property(nonatomic,strong)NSString *string;
///是否可以进行用户交互
@property(nonatomic,assign)BOOL isEnabled;

@end

@implementation CheckViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //按钮
    //编辑按钮
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitle:@"编辑" forState:(UIControlStateNormal)];
    [button setTitle:@"完成" forState:(UIControlStateSelected)];
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor redColor] forState:(UIControlStateHighlighted)];
    button.size = CGSizeMake(60, 60);
    [button addTarget:self action:@selector(endtingAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    ///返回按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"back1" heightImage:@"Unknown" targe:self action:@selector(backAction)];
    self.navigationItem.hidesBackButton = YES;
    
    //暂存
//    self.string = _note.title;
    
    //传值
    self.titleTextFiled.text = _note.title;
    self.detailTextView.text = _note.detail;
    //关闭用户交流属性
//    self.view.userInteractionEnabled = NO;
    
    
    
}
//获取当前时间
- (NSString *)currentDateWithDateFormat:(NSString *)fotmatter{
    
    ///当前时间的获取
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //设置时间格式，这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:fotmatter];
    //用【Nsdate date】可以获取系统的当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //输出格式：2016-5-25 09：30：33
    NSLog(@"%@",currentDateStr);
    return currentDateStr;
    
}
///编辑按钮
- (void)endtingAction:(UIBarButtonItem *)button{
    if ([button.title isEqualToString:@"编辑"]) {
//        button.title= @"完成";
        self.titleTextFiled.userInteractionEnabled = YES;
        self.detailTextView.userInteractionEnabled = YES;
        _isEnabled = YES;
    }else if([button.title isEqualToString:@"完成"]){
//        button.title =@"编辑";
        self.titleTextFiled.userInteractionEnabled = NO;
        self.detailTextView.userInteractionEnabled = NO;
        _isEnabled = NO;
       
    #pragma mark 数据库修改[先删除之前的数据，再重新插入新的数据]
        [[DBHandle sharedDBManager] openDB];
        //删除
        [[DBHandle sharedDBManager]deleteNoteWith:_note.title];
        //点击完成按钮时，控件里的内容已经被改变,重新给note赋值
        NoteModel *note = [NoteModel NoteWithTitle:_titleTextFiled.text detail:_detailTextView.text date:[self currentDateWithDateFormat:@"yyyy-MM-dd HH:mm:ss"]];
        //添加
        [[DBHandle sharedDBManager] insertNoteWith:note];
    
        ///将修改后的数据返回，供上一界面刷新
        NSArray *array = [[DBHandle sharedDBManager] selectAllNote];
        self.block(array);
    
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }
     button.title = self.titleTextFiled.userInteractionEnabled ? @"完成": @"编辑";
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
