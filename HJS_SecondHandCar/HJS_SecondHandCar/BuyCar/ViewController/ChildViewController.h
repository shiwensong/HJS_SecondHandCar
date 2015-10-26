//
//  ChildViewController.h
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-21.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChiledViewControllerDelegate <NSObject>

- (void)locationButtonTitle:(NSString *)title;

@end

@interface ChildViewController : UIViewController

@property (strong, nonatomic) id<ChiledViewControllerDelegate> delegate;

@end
