//
//  TSBaseModel.m
//  项目一
//
//  Created by tens on 15-8-26.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSBaseModel.h"

@implementation TSBaseModel 


/**
 *  这里是我们把所有的model抽出来建立的一个父类，我们的model需要完成的功能就是我们的属性赋值功能，我们通过 [self setValuesForKeysWithDictionary:dict]就可以给我们的属性赋值，但是这里有一个问题，当我们的属性中没有字典中对应的key的时候，系统就会出错，所以我们需要过滤一下，我们会使用KVC自带的一个方法：- (void)setValue:(id)value forUndefinedKey:(NSString *)key,这个方法什么事情都不用做，只要覆写，系统会默认帮我们去除我们属性中和NSDictionary中没有的key；
 *
 *  @param dict 我们在实例化model的时候，传过来的NSDictionary
 *
 *  @return self
 */

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            [self setValuesForKeysWithDictionary:dict];
        }else{
            NSLog(@"数据类型不是NSDictionary");
        }
    }
    return self;
}

/**
 *   这个方法什么事情都不用做，只要覆写，系统会默认帮我们去除我们属性中和NSDictionary中没有的key；
 这个方法是过滤我们属性中没有的key，意思就是说如果，我们属性中没有的key，都会在这个方法中进来，如果我们此时的value中有数组，那么我们就能根据这个数组的key找到这个数组，然后再setValue这个方法中将这个数组转化成model，并赋值，
 *
 *  @param value KVC对应的value
 *  @param key   KVC对应的key
 */


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

/**
 *  这里是我们的类方法，我们也可以通过类方法来创建
 *
 *  @param dict 我们从外面传过来的NSDictionary
 *
 *  @return 返回的是我们self
 */
+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}


@end
