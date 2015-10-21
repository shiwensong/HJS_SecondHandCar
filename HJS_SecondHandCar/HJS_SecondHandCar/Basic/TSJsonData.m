//
//  TSJsonData.m
//  项目一
//
//  Created by tens on 15-8-25.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSJsonData.h"

@implementation TSJsonData

//这里我们的类方法实现我们的功能

+ (id)JsonDataToObjectWithFileName:(NSString *)fileName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    
    NSData *picTureNewsData = [NSData dataWithContentsOfFile:filePath];
    
    id obj = [NSJSONSerialization JSONObjectWithData:picTureNewsData options:NSJSONReadingMutableContainers error:nil];
    
    return obj;
}




@end
