//
//  TSScrollView.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-24.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSScrollView.h"

@interface TSScrollView () <UIScrollViewDelegate>
{
    UIImageView *imageView;
    NSTimer *timer;
    
    NSMutableArray *_imageURLArray;
    NSMutableArray *_titleArray;
}

@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UIPageControl *pageControl;
@property(nonatomic, strong)UILabel *titleLabel;

@property(nonatomic, assign)CGFloat width;
@property(nonatomic, assign)CGFloat height;

@end

@implementation TSScrollView

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if(self){
        self.width = TScreenWidth;
        self.height = self.frame.size.height;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.width = TScreenWidth;
        self.height = self.frame.size.height;
        
        [self creatTapGesture];
    }
    return self;
}


- (void)awakeFromNib
{
    self.width = TScreenWidth;
    self.height = self.frame.size.height;
    
    [self creatTapGesture];
}


#pragma mark - Public

- (void)headerViewWithImageURLs:(NSArray *)imageURLs titles:(NSArray *)titles
{
    _imageURLArray = [NSMutableArray arrayWithArray:imageURLs];
    _titleArray = [NSMutableArray arrayWithArray:titles];
    
    [_imageURLArray addObject:[imageURLs firstObject]];
    [_imageURLArray insertObject:[imageURLs lastObject] atIndex:0];
    
    
    [self addSubview:self.scrollView];
    [self creatTapGesture];
    
    for(int i = 0 ; i < _imageURLArray.count; i++){
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width * i , 0, self.width, self.height)];
        [imageView sd_setImageWithURL:_imageURLArray[i]];
        [_scrollView addSubview:imageView];
        
    }
    [self addSubview:self.pageControl];
    [self addSubview:self.titleLabel];
    [self creatTimer];
}



#pragma mark - Private


- (void)creatTapGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}


- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(tapHeaderViewWithCurrentPage:)]) {
        
        [self.delegate tapHeaderViewWithCurrentPage:self.pageControl.currentPage];
    }
}


- (void)creatTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:2
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

    
    if (self.width * (_imageURLArray.count - 2) == offset) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
        });
        _pageControl.currentPage = 0;
    }
    _titleLabel.text = _titleArray[_pageControl.currentPage];

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
    
    if (offset == self.width * (_imageURLArray.count - 2)) {
        [_scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
        _pageControl.currentPage = 0;
    }
    
    if (offset == 0) {
        [_scrollView setContentOffset:CGPointMake(self.width * (_imageURLArray.count - 2) , 0 ) animated:NO];
        _pageControl.currentPage = _imageURLArray.count - 3;
    }
    
    NSDate *dangqiang = [[NSDate alloc] initWithTimeIntervalSinceNow:2];
    timer.fireDate = dangqiang;
    _titleLabel.text = _titleArray[_pageControl.currentPage];

}

#pragma mark - Custom Accessor

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _scrollView.contentSize = CGSizeMake(self.width * _imageURLArray.count, self.height);
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.delegate = self;
        [_scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
        
    }
    return _scrollView;
}


- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.width - 80, self.height - 20, 100, 20)];
        _pageControl.numberOfPages = _imageURLArray.count - 2;
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}


- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        
        UIView *titleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 25, TScreenWidth, 25)];
        titleBgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        [self addSubview:titleBgView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.height - 20, self.width, 20)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:13];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = _titleArray[0];
    }
    
    return _titleLabel;
}

@end
