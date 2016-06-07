//
//  HRScorollView.m
//  GD_GoodMom
//
//  Created by lanou3g on 16/6/1.
//  Copyright © 2016年 温哲. All rights reserved.
//

#import "HRScorollView.h"

//图片的宽
#define kWidth  [UIScreen mainScreen].bounds.size.width
//图片的高
#define  kHeight 120
@interface HRScorollView ()<UIScrollViewDelegate>

///轮播图的页数控制
@property(nonatomic,strong)UIPageControl *pageControl;

///定时器
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation HRScorollView

///轮播图片的数量
NSInteger images = 5;
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
       
        //初始化
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,kWidth, 120)];
        //属性
        _scrollView.contentSize = CGSizeMake(kWidth *5 , 120);
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        
        [self addSubview:_scrollView];
        //准备相册
        for (int i = 0; i < images; i ++) {
            UIScrollView *minScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(kWidth * i, 0, kWidth, kHeight)];
            minScroll.pagingEnabled = YES;
            minScroll.delegate = self;
            //添加图片
            UIImageView *imagesView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
            imagesView.image = [UIImage imageNamed:[NSString stringWithFormat:@"1%d.jpg",i +1]];
            [minScroll addSubview:imagesView];
            [_scrollView addSubview:minScroll];
        }
        //准备pageController
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(kWidth*0.5 - images*15*0.5, kHeight - 15, images * 15 + 10, 15)];
        _pageControl.numberOfPages = images;
        _pageControl.pageIndicatorTintColor = [UIColor yellowColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
        [_pageControl addTarget:self action:@selector(pageAction:) forControlEvents:(UIControlEventTouchUpInside)];
        _pageControl.backgroundColor = [UIColor purpleColor];
        [self sendSubviewToBack:_pageControl];
        [self addSubview:_pageControl];
        
        //定时器
        [self addTimer];
        
    }
    return self;
}


///定时器
- (void)addTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextPageAction) userInfo:nil repeats:YES];
    
}
- (void)stopTimer{
    [_timer invalidate];
    _timer = nil;
}
//定时器出发的事件
NSInteger pages =  0;
- (void)nextPageAction{
    
    if (pages == images - 1) {
        pages = 0;
    }else{
        pages = _pageControl.currentPage + 1;
    }
    
    [_scrollView setContentOffset:CGPointMake(pages * kWidth, 0) animated:YES];
}

//页面控制器
- (void)pageAction:(UIPageControl *)page{
    
    
    [_scrollView setContentOffset:CGPointMake(_pageControl.currentPage * kWidth, 0) animated:YES];
    
}
#pragma mark UIScrollViewDelegate代理方法
//滑动页面
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _pageControl.currentPage = _scrollView.contentOffset.x/kWidth;
}
//开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
//    _timer = nil;
}
//停止减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self addTimer];
    //显示page和偏移量
    _pageControl.currentPage = _scrollView.contentOffset.x/kWidth;
    
}



@end
