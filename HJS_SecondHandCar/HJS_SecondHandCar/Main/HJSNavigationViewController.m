//
//  HJSNavigationViewController.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-19.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "HJSNavigationViewController.h"

@interface HJSNavigationViewController ()


@end

@implementation HJSNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationBar.barTintColor =  [UIColor colorWithRed:12/255.0 green:88/255.0 blue:175/255.0 alpha:1];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
