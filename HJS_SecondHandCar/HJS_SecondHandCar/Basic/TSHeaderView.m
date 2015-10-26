//
//  TSHeaderView.m
//  项目一
//
//  Created by tens on 15-8-22.
//  Copyright (c) 2015年 tens. All rights reserved.
//



#import "TSHeaderView.h"

@interface TSHeaderView () <UIScrollViewDelegate>
{
    UIImageView *imageView;
    NSTimer *timer;

    NSMutableArray *_imagesArray;
    NSMutableArray *_titleArray;
}

@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UIPageControl *pageControl;
@property(nonatomic, strong)UILabel *titleLabel;

@property(nonatomic, assign)CGFloat width;
@property(nonatomic, assign)CGFloat height;

@end

@implementation TSHeaderView

#pragma mark - Lifecycle


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.width = TScreenWidth;
        self.height = self.frame.size.height;
    }
    return self;
}


- (void)awakeFromNib
{
    self.width = TScreenWidth;
    self.height = self.frame.size.height;
    
    NSLog(@"%s %@", __func__, NSStringFromCGRect(self.frame));
}


#pragma mark - Public

- (void)headerViewWithImageURLs:(NSArray *)images titles:(NSArray *)titles
{
    _imagesArray = [NSMutableArray arrayWithArray:images];
    _titleArray = [NSMutableArray arrayWithArray:titles];
    
    [_imagesArray addObject:[images firstObject]];
    [_imagesArray insertObject:[images lastObject] atIndex:0];
    
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    [self creatTapGesture];
    
    for(int i = 0 ; i < _imagesArray.count; i++){
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width * i , 0, self.width, self.height)];
        imageView.image = [UIImage imageNamed:_imagesArray[i]];
        [_scrollView addSubview:imageView];
    }
    [self creatTimer];
}


- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _scrollView.contentSize = CGSizeMake(self.width * _imagesArray.count, self.height);
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.delegate = self;
        [_scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
    }
    return _scrollView;
}

- (void)layoutSubviews {
    
    _pageControl.frame =CGRectMake(0, self.height - 20, self.width, 20);

}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = _imagesArray.count - 2;
        _pageControl.currentPage = 0;

        NSLog(@"%s %@", __func__, NSStringFromCGRect(self.frame));
        
        [_pageControl setValue:[UIImage imageNamed:@"startGuide_page_curent"] forKey:@"_currentPageImage"];
        [_pageControl setValue:[UIImage imageNamed:@"startGuide_page_default"] forKey:@"_pageImage"];
    }
    return _pageControl;
}

#pragma mark - Custom Accessor


- (void)creatTapGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}


- (void)tapAction:(UITapGestureRecognizer *)tap
{
    [self.delegate tapHeaderViewWithCurrentPage:self.pageControl.currentPage];
}


- (void)creatTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:5
                                             target:self
                                             selector:@selector(automaticScroll:)
                                             userInfo:nil
                                             repeats:YES];
}


- (void)automaticScroll:(NSTimer *)timer
{
    CGFloat offset = _scrollView.contentOffset.x;
    [_scrollView setContentOffset:CGPointMake(offset + self.width, 0) animated:YES];
    _pageControl.currentPage = offset / self.width ;
    
    if (self.width * (_imagesArray.count - 2) == offset) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
        });
        _pageControl.currentPage = 0;
    }
    
}

#pragma  mark - UIScrollViewDelegate


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    timer.fireDate = [NSDate distantFuture];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offset = _scrollView.contentOffset.x;
    _pageControl.currentPage = (offset -  self.width) / self.width;
    
    if (offset == self.width * (_imagesArray.count - 2)) {
        [_scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
        _pageControl.currentPage = 0;
    }
    
    if (offset == 0) {
        [_scrollView setContentOffset:CGPointMake(self.width * (_imagesArray.count - 2) , 0 ) animated:NO];
        _pageControl.currentPage = _imagesArray.count - 3;
    }
    
    //创建时间间隔，让我们的定时器在指定秒数后启动
    
    //方式一：（类方法）
//    NSDate *currentTime = [[NSDate alloc] init];
//    NSDate *date = [currentTime dateByAddingTimeInterval:2];
//    timer.fireDate = date;
    
    //方式二：（实例方法）
    NSDate *dangqiang = [[NSDate alloc] initWithTimeIntervalSinceNow:5];
    timer.fireDate = dangqiang;
}

@end

