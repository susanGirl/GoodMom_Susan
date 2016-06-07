//
//  SendFeedbackViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/6.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "SendFeedbackViewController.h"
#import <SVProgressHUD.h>
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface SendFeedbackViewController ()<UITextViewDelegate>

@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UILabel *placeholderLabel;

@end

@implementation SendFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUp ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
-(void)keyboardWillChangeFrame:(NSNotification *)notification{

    CGRect frame = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    CGFloat margin = 20;
    _textView.frame = CGRectMake(margin, CGRectGetMaxY(self.navigationController.navigationBar.frame) + margin, kScreenWidth - 2 * margin, frame.origin.y - 2 * margin - CGRectGetMaxY(self.navigationController.navigationBar.frame));
}
-(void)setUp{
    /**
     *  这是UIViewController的属性，默认是YES，这样UIViewController下如果只有一个UIScrollView或者其子类，那么会自动留出空白，让scrollView滚动经过各种bar下面能隐约看到内容，但是每个UIViewController只能有唯一一个UIScrollView或者其子类，超过一个，需要将此属性设置为NO，自己去控制留白以及坐标问题
     */
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:(UIBarButtonItemStylePlain) target:self action:@selector(sendFeedBack)];
    _textView = [[UITextView alloc]init];
    CGFloat margin  = 20;
    _textView.frame = CGRectMake(margin, CGRectGetMaxY(self.navigationController.navigationBar.frame) + margin, kScreenWidth - 2 * margin, kScreenHeight - 2 * margin - CGRectGetMaxY(self.navigationController.navigationBar.frame));
    _textView.font = [UIFont systemFontOfSize:18];
    [_textView becomeFirstResponder];
    _textView.delegate = self;
    _textView.layer.cornerRadius = 5;
    _textView.layer.masksToBounds = YES;
    [self.view addSubview:_textView];
    
    self.placeholderLabel = [[UILabel alloc]init];
    _placeholderLabel.text = [NSString stringWithFormat:@"请输入反馈，我们将为您不断的改进"];
    _placeholderLabel.textColor = [UIColor grayColor];
    _placeholderLabel.frame = CGRectMake(_textView.frame.origin.x + 10, _textView.frame.origin.y + 10, _textView.frame.size.width, 20);
    [self.view addSubview:_placeholderLabel];
    
    CGFloat buttonWidth = 30;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth - buttonWidth - 10, 5, buttonWidth, buttonWidth);
    [button addTarget:self action:@selector(dismissKeyboard) forControlEvents:(UIControlEventTouchUpInside)];
    [button setBackgroundImage:[UIImage imageNamed:@"hide"] forState:(UIControlStateNormal)];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    view.backgroundColor = [UIColor whiteColor];
    [view addSubview:button];
    _textView.inputAccessoryView = view;
}
#pragma mark---发送按钮的响应方法
-(void)sendFeedBack{
    [SVProgressHUD showWithStatus:@"发送成功"];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --- 下拉按钮的响应方法
-(void)dismissKeyboard{
    [self.textView resignFirstResponder];
}
- (void)textViewDidChange:(UITextView *)textView{


    if ([textView.text isEqualToString:@""]) {
        self.placeholderLabel.hidden = NO;
    }else{
        self.placeholderLabel.hidden = YES;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textView resignFirstResponder];

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
