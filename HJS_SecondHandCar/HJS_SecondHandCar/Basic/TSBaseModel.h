//
//  TSBaseModel.h
//  项目一
//
//  Created by tens on 15-8-26.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSBaseModel : NSObject

//创建model的实例方法
- (instancetype)initWithDictionary:(NSDictionary *)dict;

//创建model的类方法
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
