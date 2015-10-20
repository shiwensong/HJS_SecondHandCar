//
//  TSHttpRequest.m
//  TensWeibo_Demo
//
//  Created by qinglinfu on 15/10/13.
//  Copyright (c) 2015年 十安科技. All rights reserved.
//

#import "TSHttpRequest.h"
#import "AFNetworking.h"

@implementation TSHttpRequest

+ (void)requestURL:(NSString *)url parameters:(id)parames requestType:(RequestType)type success:(SuccessBlock)success failure:(FailureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    if (type == RequesetIsGET) {
        [manager GET:url parameters:parames success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if (success) {
                success(responseObject);
            }

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            if (failure) {
                
                failure(error);
            }
        }];

    } else if(type == RequestIsPOST) {
        
        [manager POST:url parameters:parames success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if (success) {
                success(responseObject);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            if (failure) {
                
                failure(error);
            }
        }];
    }
    
}

//使用我们的借口上传我们的图片并且发送一条微博
+ (void)POSTURL:(NSString *)url parameters:(id)parames datas:(NSArray *)datas success:(SuccessBlock)success failure:(FailureBlock)failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:parames constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        //将我们传进来的数据转化成我们的数组后再上传到服务器
        for (id object in datas) {
            NSData *data = UIImageJPEGRepresentation(object, 1);
            NSString *fileName = [NSString stringWithFormat:@"wb%u",arc4random()];
            [formData appendPartWithFileData:data name:@"pic" fileName:fileName mimeType:@"image/jpeg"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
