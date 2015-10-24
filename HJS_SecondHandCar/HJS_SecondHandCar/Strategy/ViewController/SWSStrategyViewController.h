//
//  SWSStrategyViewController.h
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-22.
//  Copyright (c) 2015年 tens. All rights reserved.
//

typedef NS_ENUM(long, StrategyType) {
    StrategyTypeIsFirstPage = 0,
    StrategyTypeIsSecondPage,
    StrategyTypeIsThreePage,
    StrategyTypeIsFourPage
};

#import <UIKit/UIKit.h>
#import "SWSResultModel.h"

@interface SWSStrategyViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (copy, nonatomic) NSString *URLString;
@property (assign, nonatomic) StrategyType pageType;

@property (strong, nonatomic) SWSResultModel *model;

- (void)refreshData;

@end
