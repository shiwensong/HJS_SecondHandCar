//
//  SWSResultMode.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-20.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "SWSResultMode.h"
#import "SWSCarModel.h"

@implementation SWSResultMode

- (NSMutableArray *)carModel{
    if(!_carModels){
        _carModels = [NSMutableArray array];
    }
    return _carModels;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"carlist"]) {
        NSArray *array = [NSArray arrayWithArray:value];
        for (int i = 0 ; i < array.count; i ++) {
            SWSCarModel *model = [SWSCarModel modelWithDictionary:array[i]];
            [self.carModel addObject:model];
        }
    }
}

@end
