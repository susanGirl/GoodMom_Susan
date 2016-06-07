//
//  PlayerViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/6.
//  Copyright © 2016年 温哲. All rights reserved.
//


#import "JSONKit.h"

#import "PlayerViewController.h"
#import "NetWorking.h"
#import "Recipe.h"
#import "MBProgressHUD+gifHUD.h"
@interface PlayerViewController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UIWebView  *webView;
@property(assign,nonatomic)BOOL  flag;
@property(strong,nonatomic)NSString  *playUrl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@end


static NSString * cellID = @"cellIdentifier";
@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    // 请求数据
    [self netWorkWithPalyUrl];
    
    self.navigationItem.hidesBackButton = YES;
    self.title = _name;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"清新导航条.png"] forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(backHomeAction)];
    self.navigationItem.rightBarButtonItem = backItem;
}
- (void)netWorkWithPalyUrl{
    
        NSString *url = [NSString stringWithFormat:@"http://api.douguo.net/recipe/detail/%@",_ID];
    
    
        NSLog(@"🔥🔥🔥🔥🔥🔥%@",url);
        NSString *body = @"author_id=0&client=4";
    
        [NetWorking netWorkingPostActionWithURLString:url bodyURLString:body completeHandle:^(NSData * _Nullable data) {
            NSLog(@"🔥❤️🔥%@",data);
            NSError *error = nil;
            
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
//            NSDictionary * dict = [[JSONDecoder decoder] objectWithData:data];
            
            NSLog(@"🔥🔥🔥❤️🔥🔥🔥%@->%@",dict,error);
            for (NSDictionary *listDic in dict[@"result"][@"recipe"]) {
                //            NSLog(@"电影播放列表：-》%@",listDic);
                Recipe *recipe = [Recipe new];
                [recipe setValuesForKeysWithDictionary:listDic];
                            NSLog(@"电影播放列表：-》%@",recipe.vu);
                _playUrl = recipe.vu;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                // 回到主线程-->切记刷新-->刷新UI
                [self.tableView reloadData];
            });
        }];
}
- (void)backHomeAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"好妈妈导航条.png"] forBarMetrics:UIBarMetricsDefault];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    if (_flag == NO) {
        [MBProgressHUD setupHUDWithFrame:CGRectMake(0, 0, 50, 50) gifName:@"pika" andShowToView:self.view];
        _flag = YES;
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    if (_flag == YES) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        _flag = NO;
    }
}
- (IBAction)playerButton:(id)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_playUrl]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
    
    return cell;
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
