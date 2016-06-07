//
//  MyView.m
//  UIscrollView - UI6 - 组合
//
//  Created by lanou3g on 16/3/11.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "MyView.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
@implementation MyView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self AddView];
    }
    return self;
}
- (void)AddView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth , kHeight)];
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(kWidth *7 , kHeight);

    [self addSubview:_scrollView];
    
    for (int i = 0; i < 5; i ++) {
        UIScrollView *minScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(kWidth * i, 0, kWidth, kHeight)];
        minScroll.minimumZoomScale = 0.5;
        minScroll.maximumZoomScale = 2.0;
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"1%d.jpg",i]];
        [minScroll addSubview:_imageView];
        [_scrollView addSubview:minScroll];
    }
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, kHeight - 30, kWidth, 30)];
    _pageControl.numberOfPages = 7;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor magentaColor];
    _pageControl.backgroundColor = [UIColor cyanColor];
    
    [self addSubview:_pageControl];
    [self bringSubviewToFront:_pageControl];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
