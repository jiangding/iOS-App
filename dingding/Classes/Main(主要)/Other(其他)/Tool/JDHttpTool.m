//
//  JDHttpTool.m
//  丁丁说
//
//  Created by JiangDing on 15/11/25.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDHttpTool.h"
#import "AFNetworking.h"

@implementation JDHttpTool

+ (void)get:(NSString *)url parameters:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1. 获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2. 发送请求
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }

    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)post:(NSString *)url parameters:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1. 获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2. 发送请求
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}



+ (void)post:(NSString *)url parameters:(NSMutableDictionary *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1. 获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 3. 发送请求
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (block) {
            block(formData);
        }
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
@end
