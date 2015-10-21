//
//  HJSMineViewController.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-19.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "HJSMineViewController.h"

@interface HJSMineViewController ()

@end

@implementation HJSMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

@end
