//
//  TSJsonData.h
//  项目一
//
//  Created by tens on 15-8-25.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSJsonData : NSObject

/**
 *  这是我们封装好的，传入json文件，我们就会自动将里面的数据解析出来，
 *
 *  @param fileName 这里是我们json文件的名字
 *
 *  @return 返回一个id类型的数据，基本上都是我们的 NSArray，数组里面包含了很多的 NSDictionary
 */

+ (id)JsonDataToObjectWithFileName:(NSString *)fileName;

    

@end
