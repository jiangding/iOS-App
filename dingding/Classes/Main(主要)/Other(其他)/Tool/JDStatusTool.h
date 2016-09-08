//
//  JDStatusTool.h
//  丁丁说
//
//  Created by JiangDing on 15/11/26.
//  Copyright © 2015年 JiangDing. All rights reserved.
//  封装微博业务, 字典转模型

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@class JDHomeStatusParam, JDHomeStatusResult, JDSendStatusParam, JDSendStatusResult, JDStatusCommentParam, JDStatusCommentResult, JDStatusReportParam, JDStatusReportResult, JDSendCommentParam, JDSendCommentResult,
    JDUserFansParam, JDUserFansResult
    ;

@interface JDStatusTool : NSObject

/**
 *  首页获取数据业务方法
 *
 *  @param params  params 请求参数
 *  @param success success 请求成功后返回的block
 *  @param failure failure 请求失败返回的block
 */
+ (void)getHomeStatusWithParam:(JDHomeStatusParam *)params success:(void (^)(JDHomeStatusResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  详细获取单条微博下面评论的方法
 *
 *  @param params  params 请求参数
 *  @param success success 请求成功后返回的block
 *  @param failure failure 请求失败返回的block
 */
+ (void)getSingleStatusComment:(JDStatusCommentParam *)params success:(void (^)(JDStatusCommentResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  详细页获取单条微博下面的转发
 *
 *  @param params  params 请求参数
 *  @param success success 请求成功后返回的block
 *  @param failure failure 请求失败返回的block
 */
+ (void)getSingleStatusReport:(JDStatusReportParam *)params success:(void (^)(JDStatusReportResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  发送微博的业务方法
 *
 *  @param params  params 请求参数
 *  @param success success 请求成功后返回的block
 *  @param failure failure 请求失败返回的block
 */
+ (void)postSendStatusWithParam:(JDSendStatusParam *)params success:(void (^)(JDSendStatusResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  发送微博的业务方法, 有图片
 *
 *  @param params  params 请求参数
 *  @param block   block 上传图片block
 *  @param success success 请求成功后返回的block
 *  @param failure failure 请求失败返回的block
 */
+ (void)postSendStatusWithPictureParam:(JDSendStatusParam *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>formData))block success:(void (^)(JDSendStatusResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  发送某条微博的评论的业务方法
 *
 *  @param params  params 请求参数
 *  @param success success 请求成功后返回的block
 *  @param failure failure 请求失败返回的block
 */
+ (void)postSendStatusCommentWithParam:(JDSendCommentParam *)parmas success:(void (^)(JDSendCommentResult *result))success failure:(void (^)(NSError *error))failure;


/**
 *  获取用户粉丝的业务方法
 *
 *  @param params  params 请求参数
 *  @param success success 请求成功后返回的block
 *  @param failure failure 请求失败返回的block
 */
+ (void)getUserFansWithParam:(JDUserFansParam *)params success:(void (^)(JDUserFansResult *result))success failure:(void (^)(NSError *error))failure;

@end
