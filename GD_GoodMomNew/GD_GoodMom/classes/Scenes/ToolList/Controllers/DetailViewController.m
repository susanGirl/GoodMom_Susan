//
//  DetailViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "DetailViewController.h"
#import "DBHandle.h"

@interface DetailViewController ()
#warning 数据库的属性
@property(nonatomic,strong)DBHandle *dbhandle;


@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *detailTextFiled;

@end

@implementation DetailViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.titleTextField.text = self.note.title;
    self.detailTextFiled.text = self.note.detail;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"写日记";
         _titleTextField.text = _note.title;
    _titleTextField.font =  [UIFont fontWithName:@"Helvetica-Bold" size:18];
       _detailTextFiled.text = _note.detail;
    _detailTextFiled.font =  [UIFont fontWithName:@"Helvetica-Bold" size:18];

    self.navigationItem.hidesBackButton = YES;
    
   
    
    UIButton *cancel = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [cancel setTitle:@"返回" forState:(UIControlStateNormal)];
    [cancel setTitleColor:[UIColor cyanColor] forState:(UIControlStateNormal)];
    [cancel addTarget:self action:@selector(cancelAction:) forControlEvents:(UIControlEventTouchUpInside)];
    cancel.size = CGSizeMake(60, 60);
    UIBarButtonItem *cancelitem = [[UIBarButtonItem alloc]initWithCustomView:cancel];
    self.navigationItem.leftBarButtonItem = cancelitem;
    UIButton *finish = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [finish setTitle:@"保存" forState:(UIControlStateNormal)];
    [finish setTitleColor:[UIColor cyanColor] forState:(UIControlStateNormal)];
    [finish addTarget:self action:@selector(finishAction:) forControlEvents:(UIControlEventTouchUpInside)];
    finish.size = CGSizeMake(60, 60);
    UIBarButtonItem *finishitem = [[UIBarButtonItem alloc]initWithCustomView:finish];
    self.navigationItem.rightBarButtonItem = finishitem;
    
 
}


//取消按钮
- (void)cancelAction:(UIButton *)button{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否放弃编辑这篇日记" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"是" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:OKAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
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

//完成按钮事件
- (void)finishAction:(UIButton *)button{
#warning 数据库添加
    _dbhandle = [DBHandle sharedDBManager];
    [_dbhandle openDB];
    self.note = [NoteModel new];
    _note = [NoteModel NoteWithTitle:self.titleTextField.text detail:self.detailTextFiled.text date:[self currentDateWithDateFormat:@"yyyy-MM-dd HH:mm:ss"]];
    
#warning 修改1：添加了数据库添加时的提示框
    BOOL result =  [_dbhandle insertNoteWith:_note];
    if (result) {
        UIAlertController *alertControler = [UIAlertController alertControllerWithTitle:@"保存成功" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *OKAction= [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            //返回前一个页面
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        [alertControler addAction:OKAction];
        [self presentViewController:alertControler animated:YES completion:nil];
    }else{
        UIAlertController *alertControler = [UIAlertController alertControllerWithTitle:@"保存失败" message:@"请重新保存！" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *OKAction= [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            //不作为
            
        }];
        [alertControler addAction:OKAction];
        [self presentViewController:alertControler animated:YES completion:nil];
        
        
    }
    //    [_dbhandle insertNoteWith:_note];
    
    NSArray *array = [_dbhandle selectAllNote].mutableCopy;
    self.block(array);
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
