//
//  AboutViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/6.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "AboutViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface AboutViewController ()
@property(nonatomic,strong)UIImageView *imgView;//图片
@property(nonatomic,strong)UILabel *contentLabel;//内容
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1.0];
    self.view.backgroundColor = kGlobalBackgroudColor;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:91/255.0 blue:197/255.0 alpha:1.0];

    self.title = @"关于我们";
    [self setUp];

}
-(void)setUp{

    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(120, 100, 150, 150)];
    self.imgView.image = [UIImage imageNamed:@"icon.jpg"];
    self.imgView.layer.cornerRadius = 75;
    self.imgView.layer.masksToBounds = YES;
    CGFloat margin = 20;
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 210, kScreenWidth - 2 * margin, 300)];
    _contentLabel.text = @"     “好妈妈”是一款育儿的好应用，为广大孕妈度身定制的一款孕期工具，能帮助孕妈记录整个孕期的心情及身体变化情况，并适时地提醒您在每个怀孕阶段的注意事项。促进妈妈间的沟通交流，获取育儿经验，饮食健康哒，着装美美哒。";
    _contentLabel.numberOfLines = 0;
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_contentLabel];
    [self.view addSubview:self.imgView];
    
    
    
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
