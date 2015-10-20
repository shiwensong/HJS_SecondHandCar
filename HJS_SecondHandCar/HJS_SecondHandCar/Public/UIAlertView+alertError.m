//
//  UIAlertView+alertError.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-20.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "UIAlertView+alertError.h"

@implementation UIAlertView (alertError)

+ (void)alertErrorView{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"网络错误，请检查你的网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
