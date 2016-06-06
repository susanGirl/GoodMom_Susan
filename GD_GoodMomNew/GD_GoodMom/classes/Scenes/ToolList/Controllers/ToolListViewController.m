//
//  ToolListViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/23.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "ToolListViewController.h"
#import "ToolModel.h"
#import "MyView.h"
#import "HRScorollView.h"
#import "KnowledgeController.h"//孕期知识

//屏幕宽度宏
#define kWidth  [UIScreen mainScreen].bounds.size.width

@interface ToolListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
///主题的视图
@property(nonatomic,strong)UICollectionView *collectionView;
///工具箱中的工具数组
@property(nonatomic,strong)NSArray *toolArray;
///图片数组
@property(nonatomic,strong)NSArray *imageArray;
///model的数组
@property(nonatomic,strong)NSMutableArray *modelArray;
///轮播图
@property(nonatomic,strong)HRScorollView *scrolView;

@end
static NSString *const ToolCellID = @"ToolCellID";
static NSString *const HeaderViewID = @"HeaderViewID";
@implementation ToolListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"工具";
    self.view.backgroundColor = [UIColor colorWithRed:0.8 green:0.2 blue:0.8 alpha:1.0];
    
    
    self.toolArray = [NSArray arrayWithObjects:@"心情手札",@"故事会",@"孕期知识", nil];
    _modelArray = [NSMutableArray array];
    for (NSString *string in self.toolArray) {
        ToolModel *tool = [ToolModel new];
        tool.title = string;
        tool.iconImage = string;
        NSLog(@"%@",tool.title);
        [_modelArray addObject:tool];
    }
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(306, 369);
    layout.sectionInset = UIEdgeInsetsMake(30, 30, 30, 30);
    layout.headerReferenceSize = CGSizeMake(0, 120);
    
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    //注册item
    [_collectionView registerNib:[UINib nibWithNibName:@"ToolCell" bundle:nil] forCellWithReuseIdentifier:ToolCellID];
    //注册头部视图
    [_collectionView registerClass:[HRScorollView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderViewID];
    //背景颜色
    _collectionView.backgroundColor = [UIColor colorWithRed:255/255.0 green:91/255.0 blue:197/255.0 alpha:1.0];
    [self.view addSubview:_collectionView];
    
    
    
    
}


#pragma mark 页面加载时更新数据
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
}

#pragma mark UICollectionViewControllerDelegate代理方法
//一个分区内的行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.toolArray.count;
}
//设置cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ToolCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ToolCellID forIndexPath:indexPath];
    ToolModel *tool = _modelArray[indexPath.row];
    NSLog(@"%@",tool.title);
    cell.tool = tool;
    
    return cell;
    
}
//设置区头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    HRScorollView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderViewID forIndexPath:indexPath];
    //    header.backgroundColor = [UIColor purpleColor];
    return header;
    
}
//选中item方法事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        NoteController *noteVC = [[NoteController alloc]init];
#warning 数据库查询
        noteVC.noteArray = [[DBHandle sharedDBManager] selectAllNote].mutableCopy;
        
        [self.navigationController pushViewController:noteVC animated:YES];
    }else if (indexPath.row == 1){
        StoryController *storyVC = [StoryController new];
        
        [self.navigationController pushViewController:storyVC animated:YES];
        
    }else if (indexPath.row == 2){
        KnowledgeController *knowledgeVC = [[KnowledgeController alloc]init];
        [self.navigationController pushViewController:knowledgeVC animated:YES];
        
    }
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
