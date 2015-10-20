//
//  SWSResultMode.h
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-20.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSBaseModel.h"
#import "SWSCarModel.h"


@interface SWSResultMode : TSBaseModel

/**  
 pagecount = 365;
 pageindex = 1;
 pagesize = 24;
 rowcount = 8742;
 */
@property (assign, nonatomic) NSNumber *pagecount;
@property (assign, nonatomic) NSNumber *pageindex;
@property (strong, nonatomic) NSNumber *pagesize;
@property (strong, nonatomic) NSNumber *rowcount;

@property (strong, nonatomic) NSMutableArray *carModels;

@end
