//
//  NSString+ToPinyin.m
//  TensWeiBo_demo
//
//  Created by tens on 15-10-16.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "NSString+ToPinyin.h"

@implementation NSString (ToPinyin)

- (NSString *)topinyin{
    
    NSMutableString *mutableString = [[NSMutableString alloc] initWithString:self];
    
    //将我们的汉字转化成我们的拼音
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, NO);
    
    //去除我们的音标
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, NO);
    
    //去除空格
    [mutableString replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, mutableString.length)];

    return mutableString;
}

@end
