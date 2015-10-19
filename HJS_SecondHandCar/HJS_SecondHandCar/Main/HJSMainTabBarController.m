//
//  HJSMainTabBarController.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-19.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "HJSMainTabBarController.h"

@interface HJSMainTabBarController ()



@end

@implementation HJSMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabbarControllerBarButtonSelected];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//设置tabbarControllerButtonSelected
-  (void)setTabbarControllerBarButtonSelected{
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.tintColor = [UIColor colorWithRed:54/255.0 green:116/255.0 blue:170/255.0 alpha:1];
    
    NSArray *selectedImage = @[@"label_buy_pre",
                               @"label_sale_pre",
                               @"label_tool_pre",
                               @"label_Raiders_pre",
                               @"label_my_pre",
                               ];
    NSArray *viewControllers = self.viewControllers;
    for (int i = 0; i < 5; i ++) {
        UIViewController *viewController = viewControllers[i];
        NSString *selectedImageName = selectedImage[i];
        UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
        viewController.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
}
@end
