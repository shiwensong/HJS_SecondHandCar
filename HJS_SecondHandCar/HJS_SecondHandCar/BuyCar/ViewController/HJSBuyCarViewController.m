//
//  HJSBuyCarViewController.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-19.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "HJSBuyCarViewController.h"
#import "SearchView.h"

@interface HJSBuyCarViewController ()

@property (weak, nonatomic) IBOutlet UIView *searchBgView;//搜索框的背景View

@end

@implementation HJSBuyCarViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSearchBgViewSearchCar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

//设置我们的navigationBar的搜索框
- (void)setSearchBgViewSearchCar
{
    SearchView *searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, 130, 30)];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 130, 30)];
    UIImage *bgImage = [UIImage imageNamed:@"detail_newcar_none"];
    bgImageView.layer.cornerRadius = 10;
    bgImageView.layer.masksToBounds = YES;
    bgImageView.image = bgImage;
    bgImageView.alpha = 0.7;
    [searchView addSubview:bgImageView];
    [self.searchBgView addSubview:searchView];
}

@end
