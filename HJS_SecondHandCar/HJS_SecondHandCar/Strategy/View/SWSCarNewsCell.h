//
//  SWSCarNewsCell.h
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-22.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWSCarNewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLable;


@end
