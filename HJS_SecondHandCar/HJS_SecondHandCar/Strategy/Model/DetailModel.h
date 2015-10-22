//
//  DetailModel.h
//  HJS_SecondHandCar
//
//  Created by tens on 15-10-22.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSBaseModel.h"

@interface DetailModel : TSBaseModel


@property (copy, nonatomic) NSString *articleid;
@property (copy, nonatomic) NSString *articleintroduce;
@property (copy, nonatomic) NSString *articlepublishdate;
@property (copy, nonatomic) NSString *articletitle;
@property (copy, nonatomic) NSString *classid;
@property (copy, nonatomic) NSString *classname;
@property (copy, nonatomic) NSString *imgurl;
@property (copy, nonatomic) NSString *url;

//    articleid = 852680;
//    articleintroduce = "[\U4e8c\U624b\U8f66\U4e4b\U5bb6 \U653f\U7b56\U6cd5\U89c4]  \U8fd1\U671f\U5f88\U591a\U7f51\U53cb\U5728\U6211\U4eec";
//    articlepublishdate = "2015-10-14 17:47";
//    articletitle = "\U4e8c\U624b\U8f66\U8f86\U8fc7\U6237\U53d8\U66f4\U6d41\U7a0b\U8be6\U89e3-\U5317\U4eac\U5730\U533a";
//    classid = 120;
//    classname = "\U653f\U7b56\U6cd5\U89c4";
//    imgurl = "http://2sc0.m.autoimg.cn/2scimg/ArticlePic/2015/10/14/152x114_0_q30_4882024092986778559.jpg";
//    typeid = 1;
//    typename = "\U539f\U521b";
//    url = "http://m.app.che168.com/strategy/852680.html?isapp=1";


@end
