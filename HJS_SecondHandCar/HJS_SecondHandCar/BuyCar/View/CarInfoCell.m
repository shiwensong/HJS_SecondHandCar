//
//  CarInfoCell.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-20.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "CarInfoCell.h"

@interface CarInfoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *carImageView;
@property (weak, nonatomic) IBOutlet UILabel *carNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *carTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *carBrithLabel;
@property (weak, nonatomic) IBOutlet UILabel *carPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *carSellTimeLabel;


@end

@implementation CarInfoCell

#pragma mark - Lifecycle

- (void)awakeFromNib {
    self.carPriceLabel.textColor = [UIColor colorWithRed:252 / 255.0 green:81 / 255.0 blue:33 / 255.0 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Custom Accessor

- (void)setModel:(SWSCarModel *)model{
    _model = model;
    [self.carImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    
    self.carNameLabel.text = model.SeriesName;
    self.carTypeLabel.text = model.SpecName;
    self.carPriceLabel.text = [NSString stringWithFormat:@"%@ 万",model.price];
    self.carSellTimeLabel.text = [model.publishdate substringWithRange:NSMakeRange(5, 5)];
    self.carBrithLabel.text = [NSString stringWithFormat:@"%@万公里/%@年",model.mileage,model.registrationdate];
}

@end
