//
//  HJSToolViewController.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-19.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "HJSToolViewController.h"
#import "EvaluateViewController.h"

@interface HJSToolViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation HJSToolViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Protol Group

#pragma mark - UITableViewDataSource




#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        EvaluateViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EvaluateViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}


@end
