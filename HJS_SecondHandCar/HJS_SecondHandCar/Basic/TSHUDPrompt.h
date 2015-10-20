//
//  TSHUDPrompt.h
//  项目一
//
//  Created by tens on 15-8-29.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface TSHUDPrompt : NSObject

/**
 *  这里封装一个我们的提示框的创建方法
 *
 *  @param title        提示框需要显示的文字
 *  @param imageName    需要显示图片的文字
 *  @param view         传入我们提示框需要添加的UIView
 *  @param tiemInterval 传入我们提示框消失的时间间隔
 */
+ (void)hudPromptWithTitle:(NSString *)title withImageName:(NSString *)imageName withSuperView:(UIView *)view withAfterDelay:(NSTimeInterval)tiemInterval;

@end
