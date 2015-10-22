//
//  SWSResultModel.h
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-22.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSBaseModel.h"

@interface SWSResultModel : TSBaseModel

/***
 pagecount = 18;
 pagesize = 30;
 rowcount = 526;
 */
@property (strong, nonatomic) NSNumber *pagecount;
@property (strong, nonatomic) NSNumber *pagesize;
@property (strong, nonatomic) NSNumber *rowcount;

@property (strong, nonatomic) NSMutableArray *detailModelArray;

@end
