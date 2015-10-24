//
//  SWSResultModel.m
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-22.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "SWSResultModel.h"
#import "DetailModel.h"

@implementation SWSResultModel

#pragma mark - Lifecycle

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super initWithDictionary:dict];
    if (self) {
        
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"articlelist"]) {

        NSArray *array = (NSArray *)value;
        for (NSDictionary *dictionary  in array) {
//            NSLog(@"dictionary ==%@",dictionary);
            DetailModel *model = [DetailModel modelWithDictionary:dictionary];
            [self.detailModelArray addObject:model];
        }
        
        NSLog(@"%@",self.detailModelArray);
    }
}


#pragma mark - Custom accessor

- (NSMutableArray *)detailModelArray{
    if (_detailModelArray == nil) {
        _detailModelArray = [NSMutableArray array];
    }
    return _detailModelArray;
}

@end
