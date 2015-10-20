//
//  TSHUDPrompt.m
//  项目一
//
//  Created by tens on 15-8-29.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSHUDPrompt.h"

@implementation TSHUDPrompt

+ (void)hudPromptWithTitle:(NSString *)title withImageName:(NSString *)imageName withSuperView:(UIView *)view withAfterDelay:(NSTimeInterval)tiemInterval
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:window];
    
    if (title != nil) {
        HUD.labelText = title;
    }
    
    if (imageName != nil) {
        HUD.mode = MBProgressHUDModeCustomView;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        HUD.customView = imageView;
    }
    
    HUD.removeFromSuperViewOnHide = YES;
    [view addSubview:HUD];
    [HUD show:YES];
    
    [HUD hide:YES afterDelay:tiemInterval];
}

@end
