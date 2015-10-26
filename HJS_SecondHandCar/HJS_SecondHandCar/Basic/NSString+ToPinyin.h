//
//  NSString+ToPinyin.h
//  TensWeiBo_demo
//
//  Created by tens on 15-10-16.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ToPinyin)

/**
 *  将我们的汉字转换成拼音
 *
 *  @return 返回的就是我们汉字拼音拼接起来的字符串
 */
- (NSString *)topinyin;

@end
