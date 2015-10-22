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

@interface HJSStrategyViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation HJSStrategyViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    

    self.scrollView.backgroundColor = [UIColor orangeColor];
}

- (void)viewDidAppear:(BOOL)animated{
    [self setScrollviewSetting];

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
    
    NSLog(@"height == %f", height);
    self.scrollView.contentSize = CGSizeMake(TScreenWidth * 4, height);
    //添加我们的tableView
    self.scrollView.showsHorizontalScrollIndicator = YES;
    self.scrollView.showsVerticalScrollIndicator = YES;
    for (int i = 0; i < 4; i ++) {
        
        SWSStrategyViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SWSStrategyViewController"];
        viewController.view.frame = CGRectMake(TScreenWidth * i, 0 , TScreenWidth, height);
        viewController.tableView.backgroundColor = [UIColor randomColor];
        
        if (i == 0) {
            viewController.URLString = SWSStrategyAllArticleURL;
        }else if(i == 1){
            viewController.URLString = SWSBuyCarCommonSenseURL;
        }else if(i == 2){
            viewController.URLString = SWSLawsAndRegulationsURL;
        }else if(i == 3){
            viewController.URLString = SWSIndustryInformationURL;
        }
        
        [self.scrollView addSubview:viewController.view];
        [self addChildViewController:viewController];
    }
}

@end