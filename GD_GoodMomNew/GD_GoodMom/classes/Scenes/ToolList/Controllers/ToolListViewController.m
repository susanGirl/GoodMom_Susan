//
//  ToolListViewController.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/5/23.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "ToolListViewController.h"
#import "ToolModel.h"

@interface ToolListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
///主题的视图
@property(nonatomic,strong)UICollectionView *collectionView;
///工具箱中的工具数组
@property(nonatomic,strong)NSArray *toolArray;
///图片数组
@property(nonatomic,strong)NSArray *imageArray;
///model的数组
@property(nonatomic,strong)NSMutableArray *modelArray;

@end
static NSString *const ToolCellID = @"ToolCellID";
static NSString *const HeaderViewID = @"HeaderViewID";
@implementation ToolListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"工具";
    self.view.backgroundColor = [UIColor colorWithRed:0.8 green:0.2 blue:0.8 alpha:1.0];
    
    
    self.toolArray = [NSArray arrayWithObjects:@"心情手札",@"故事会",@"孕期知识",@"123", nil];
    _modelArray = [NSMutableArray array];
    for (NSString *string in self.toolArray) {
        ToolModel *tool = [ToolModel new];
        tool.title = string;
        tool.iconImage = string;
        NSLog(@"%@",tool.title);
        [_modelArray addObject:tool];
    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(140, 200);
    layout.sectionInset = UIEdgeInsetsMake(30, 30, 30, 30);
    layout.headerReferenceSize = CGSizeMake(0, 120);
    
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    //注册
    [_collectionView registerNib:[UINib nibWithNibName:@"ToolCell" bundle:nil] forCellWithReuseIdentifier:ToolCellID];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderViewID];
    
    _collectionView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(200)/225.0 green:arc4random_uniform(200)/225.0 blue:arc4random_uniform(200)/225.0 alpha:1.0];
    [self.view addSubview:_collectionView];
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.toolArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ToolCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ToolCellID forIndexPath:indexPath];
    ToolModel *tool = _modelArray[indexPath.row];
    NSLog(@"%@",tool.title);
    cell.tool = tool;
    
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderViewID forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"9.jpg"]];
    imageView.frame = header.frame;
    [header addSubview:imageView];
    header.backgroundColor = [UIColor purpleColor];
    return header;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        NoteController *noteVC = [[NoteController alloc]init];
#warning 数据库查询
        noteVC.noteArray = [[DBHandle sharedDBManager] selectAllNote].mutableCopy;

        [self.navigationController pushViewController:noteVC animated:YES];
    }else if (indexPath.row == 1){
        StoryController *storyVC = [StoryController new];
        
        [self.navigationController pushViewController:storyVC animated:YES];
        
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
