//
//  StrategyDetaileViewController.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-23.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "StrategyDetaileViewController.h"

#import "MBProgressHUD.h"
@interface StrategyDetaileViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) MBProgressHUD *HUD;

@end

@implementation StrategyDetaileViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url =[NSURL URLWithString:self.URLString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    //设置titleView的字体颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Protol Group

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    self.HUD.labelText = @"拼命加载中。。。";
    
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.HUD.labelText = @"加载完成！";
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"has_been_sent"]];
    self.HUD.mode = MBProgressHUDModeCustomView;
    self.HUD.customView = imageView;
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.view addSubview:self.HUD];
    
    [self.HUD hide:YES afterDelay:1];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [UIAlertView alertErrorView];
}

#pragma mark - Custom Accessor

- (MBProgressHUD *)HUD{
    if (!_HUD) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        _HUD = [[MBProgressHUD alloc] initWithView:keyWindow];
    }
    return _HUD;
}





@end
