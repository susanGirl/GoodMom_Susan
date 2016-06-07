//
//  HomeListViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "HomeListViewController.h"

@interface HomeListViewController ()

@end

@implementation HomeListViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.tabBarItem.title = @"商城";
        [self.tabBarItem setImage:[UIImage imageNamed:@"Home"]];
        [self.tabBarItem setSelectedImage:[UIImage imageNamed:@"Home-H"]];
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"好妈妈导航条.png"] forBarMetrics:UIBarMetricsDefault];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
