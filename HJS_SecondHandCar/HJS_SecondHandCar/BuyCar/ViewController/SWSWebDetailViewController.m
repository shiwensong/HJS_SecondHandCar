//
//  SWSWebDetailViewController.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-20.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "SWSWebDetailViewController.h"

@interface SWSWebDetailViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) MBProgressHUD *HUD;

@end

@implementation SWSWebDetailViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSURL *url =[NSURL URLWithString:self.URLString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Protol Group

#pragma mark - UIWebViewDelegate

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    
//   
//}

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
    
    [self.HUD hide:YES afterDelay:3];
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


//screening_shadow_r@2x   竖线

@end