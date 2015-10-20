//
//  HJSSellCarViewController.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-19.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "HJSSellCarViewController.h"
#import "TSHeaderView.h"
#import "SWSWebDetailViewController.h"

@interface HJSSellCarViewController ()

/**  这里是我们的滚动视图*/
@property (weak, nonatomic) IBOutlet TSHeaderView *headerView;


@end

@implementation HJSSellCarViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)setScrollView{
    self.headerView.backgroundColor = [UIColor colorWithRed:231/255.0 green:234/255.0 blue:236 / 255.0 alpha:1];
    NSArray *images = @[@"sale_guide_0",
                        @"sale_guide_1",
                        @"sale_guide_2",
                        @"sale_guide_3",
                        @"sale_guide_4"
                        ];
    [_headerView headerViewWithImageURLs:images titles:nil];
    
}

#pragma mark - IBAction

- (IBAction)merchantSellCarAction:(UIButton *)sender {
    
    
}

- (IBAction)personSellCarAction:(UIButton *)sender {
    
}


@end
