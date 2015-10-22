//
//  UIColor+randomColor.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-22.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "UIColor+randomColor.h"

@implementation UIColor (randomColor)

+ (UIColor *)randomColor{
    CGFloat red = arc4random() % 255;
    CGFloat green = arc4random() % 255;
    CGFloat blue = arc4random() % 255;
    return [UIColor colorWithRed:red/ 255.0 green:green/ 255.0 blue:blue/ 255.0 alpha:1];
}

@end
