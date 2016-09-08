//
//  JDHttpTool.h
//  丁丁说
//
//  Created by JiangDing on 15/11/25.
//  Copyright © 2015年 JiangDing. All rights reserved.
//  负责所有的网络请求

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface JDHttpTool : NSObject

/**
 *  所有的get方法
 *
 *  @param url     请求url
 *  @param params  请求参数
 *  @param success 请求成功调用
 *  @param failure 请求失败调用
 */
+ (void)get:(NSString *)url parameters:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


/**
 *  所有的post方法
 *
 *  @param url     请求url
 *  @param params  请求参数
 *  @param success 请求成功调用
 *  @param failure 请求失败调用
 */
+ (void)post:(NSString *)url parameters:(NSMutableDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


/**
 *  post 上传图片方法
 *
 *  @param url     请求url
 *  @param params  请求参数
 *  @param block   上传图片block
 *  @param success 请求成功调用
 *  @param failure 请求失败调用
 */
+ (void)post:(NSString *)url parameters:(NSMutableDictionary *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>formData))block success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
 
@end
