//
//  SWSCarModel.h
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-20.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSBaseModel.h"

@interface SWSCarModel : TSBaseModel

/**   BrandName = "\U957f\U57ce";
 Brandid = 77;
 Environmental = "\U6b274";
 SeriesName = "\U957f\U57ceM1";
 SeriesYear = "2009\U6b3e";
 Seriesid = 535;
 SpecName = "2009\U6b3e 1.3L \U4e24\U9a71\U8212\U9002\U578b";
 activitytype = 0;
 bailmoney = 50000;
 carid = 6329902;
 carname = "\U957f\U57ceM1 2009\U6b3e 1.3L \U4e24\U9a71\U8212\U9002\U578b";
 cid = 510100;
 cname = "\U6210\U90fd";
 countrytype = 2;
 creditid = 0;
 dealertype = 9;
 extrepair = 1;
 flowmode = 100;
 fromtype = 50;
 goodcarofpic = 1;
 haswarranty = 0;
 haswarrantydate = 0;
 image = "http://2sc2.autoimg.cn/escimg/g17/M12/AA/7F/320x240_0_q87_autohomecar__wKjBxlYg89-AEtl9AAJJHKojYjA415.jpg";
 installment = 1;
 invoice = 1;
 isbailcar = 1;
 isnew = 0;
 isnewcar = 0;
 isoutsite = 0;
 mileage = "3.7";
 pdate = "10-17";
 pid = 510000;
 pname = "\U56db\U5ddd";
 price = "1.59";
 publishdate = "2015-10-17 10:55:19";
 registrationdate = 2009;
 saledealerprice = 0;
 seriesyearid = 1564;
 sourceid = 1;
 specid = 6056;
*/
@property (copy, nonatomic) NSString *BrandName;//品牌名称
@property (copy, nonatomic) NSString *SeriesName;//完整的名称

@property (copy, nonatomic) NSString *SpecName; //车辆的类型介绍

@property (copy, nonatomic) NSString *activitytype;//车辆的说明书

@property (copy, nonatomic) NSString *image;//图片的URl链接地址

@property (copy, nonatomic) NSString *price;//汽车的价格

@property (copy, nonatomic) NSString *publishdate;//发出卖车信息的时间

@property (copy, nonatomic) NSString *mileage;//汽车的公里数

@property (copy, nonatomic) NSString *registrationdate;//汽车的购买时间

@property (copy, nonatomic) NSString *carid;//汽车详细页面的网页名称（进入详情页面的时候需要使用到）

@end
