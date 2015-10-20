//
//  TSHttpRequest.h
//  TensWeibo_Demo
//
//  Created by qinglinfu on 15/10/13.
//  Copyright (c) 2015年 十安科技. All rights reserved.
//

typedef enum : NSUInteger {
    RequesetIsGET,
    RequestIsPOST
} RequestType;

typedef void(^SuccessBlock)(id result);
typedef void(^FailureBlock)(id error);

#import <Foundation/Foundation.h>

@interface TSHttpRequest : NSObject

/**
 *  上传普通文本的POST/GET请求
 *
 *  @param url     请求的链接地址
 *  @param parames 请求的参数
 *  @param type    请求的类型GET\POST
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */
+ (void)requestURL:(NSString *)url parameters:(id)parames requestType:(RequestType)type success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 *  这是需要上传图片的POST请求，
 *
 *  @param url     链接地址
 *  @param parames 请求参数
 *  @param datas   媒体的数组
 *  @param success 成功的block
 *  @param failure 失败的block
 */
+ (void)POSTURL:(NSString *)url parameters:(id)parames datas:(id)datas success:(SuccessBlock)success failure:(FailureBlock)failure;


@end
