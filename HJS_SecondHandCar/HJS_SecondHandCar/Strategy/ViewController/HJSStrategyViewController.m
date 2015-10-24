//
//  HJSStrategyViewController.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-19.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "HJSStrategyViewController.h"
#import "SWSStrategyViewController.h"

#import "UIColor+randomColor.h"
#import "SWSResultModel.h"
#import "DetailModel.h"

@interface HJSStrategyViewController () <UIScrollViewDelegate> {
    int _beginOffSet;
    BOOL isContinue;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//@property (strong, nonatomic) SWSResultModel *resultModel;
@property (strong, nonatomic) NSMutableArray *resultModels;

@property (strong, nonatomic) NSMutableArray *viewControllers;

@end

@implementation HJSStrategyViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self loadResultModelDatas];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if(self.viewControllers.count == 0 ){
        
        [self setScrollviewSetting];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [self removeFromParentViewController];
}

#pragma mark - Private

- (void)setScrollviewSetting{
    
    CGFloat height = CGRectGetHeight(self.scrollView.frame);
    
//    NSLog(@"height == %f", height);
    self.scrollView.contentSize = CGSizeMake(TScreenWidth * 4, height);
    //添加我们的tableView
//    self.scrollView.showsHorizontalScrollIndicator = YES;
//    self.scrollView.showsVerticalScrollIndicator = YES;
    for (int i = 0; i < 4; i ++) {
        
        SWSStrategyViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SWSStrategyViewController"];
        viewController.view.frame = CGRectMake(TScreenWidth * i, 0 , TScreenWidth, height);
        viewController.pageType = i;
        [self.viewControllers addObject:viewController];
        [self.scrollView addSubview:viewController.view];
        [self addChildViewController:viewController];
        
        if (i == 0) {
            [viewController refreshData];
        }
    }
}


- (void)loadResultModelDatas{
    
    [self loadStrategyNewDatas:SWSStrategyAllArticleURL];
    [self loadStrategyNewDatas:SWSBuyCarCommonSenseURL];
    [self loadStrategyNewDatas:SWSLawsAndRegulationsURL];
    [self loadStrategyNewDatas:SWSIndustryInformationURL];
}

//加载我们的strategyViewController
- (void)loadStrategyNewDatas:(NSString *)URLString {
    [TSHttpRequest requestURL:URLString parameters:nil requestType:RequesetIsGET success:^(id result) {
        
         SWSResultModel *model = [[SWSResultModel alloc] initWithDictionary:result[@"result"]];
        [self.resultModels addObject:model];
    } failure:^(id error) {
        [UIAlertView alertErrorView];
    }];

}



#pragma mark - IBAction

- (IBAction)strategyButtonAction:(UIButton *)sender {
    
    if(sender.tag == 0){
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if(sender.tag == 1){
        [self.scrollView setContentOffset:CGPointMake(TScreenWidth, 0) animated:YES];
    }else if (sender.tag == 2){
        [self.scrollView setContentOffset:CGPointMake(TScreenWidth * 2, 0) animated:YES];
    }else if (sender.tag == 3){
        [self.scrollView setContentOffset:CGPointMake(TScreenWidth * 3, 0) animated:YES];
    }
}

#pragma mark - Protol Group

#pragma mark - UIScrollViewDelegate


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    _beginOffSet = (int)scrollView.contentOffset.x;
}

//计算出我们的页面是往那边滚动的，然后计算出，下一个页面的下标，然后根据下标，取出当前的ViewController，然后进行一系列的刷新操作
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offset = scrollView.contentOffset.x;
    
    CGFloat x = offset-_beginOffSet;

    if (-x > TScreenWidth/2.0) {
        if (!isContinue) {
            int page = offset/TScreenWidth;//这里的page是我们的页面的下标，与我们的数组下标匹配
            //            NSLog(@"第%d页", page);
            SWSStrategyViewController *viewController = self.viewControllers[page];
            [viewController refreshData];
            viewController.pageType = page;
        }
        isContinue = YES;
    }

    if (x > TScreenWidth/2.0) {
        
        if (!isContinue) {
            int page = offset/TScreenWidth+1;
//            NSLog(@"第%d页", page);
            SWSStrategyViewController *viewController = self.viewControllers[page];
            [viewController refreshData];
            viewController.pageType = page;
        }
        isContinue = YES;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    isContinue = NO;
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    SWSStrategyViewController *viewController = nil;
    if (targetContentOffset->x == 0) {
        viewController = self.viewControllers[0];

    }else if (targetContentOffset->x  == TScreenWidth) {
        viewController = self.viewControllers[1];

    }else if(targetContentOffset->x == TScreenWidth * 2){
        viewController = self.viewControllers[2];

    }else if(targetContentOffset->x == TScreenWidth *3){
        viewController = self.viewControllers[3];

    }
    [viewController refreshData];
}


#pragma mark - Custom Accessor

-(NSMutableArray *)viewControllers{
    
    if (_viewControllers == nil) {
        _viewControllers = [NSMutableArray array];
    }
    return _viewControllers;
}

- (NSMutableArray *)resultModels{
    if (!_resultModels) {
        _resultModels = [NSMutableArray array];
    }
    return _resultModels;
}


@end