//
//  HJSMineViewController.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-19.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "HJSMineViewController.h"
#import "SWSSettingViewController.h"


@interface HJSMineViewController ()

//拨打电话
- (IBAction)callPhoneOnCilick:(UIButton *)sender;

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

#pragma mark - IBAction

- (IBAction)settingButtonAction:(UIButton *)sender {
    
    SWSSettingViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SWSSettingViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)callPhoneOnCilick:(UIButton *)sender {
    
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://010-59851369"]];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
