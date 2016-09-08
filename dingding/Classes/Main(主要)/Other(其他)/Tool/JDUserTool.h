//
//  JDUserTool.h
//  丁丁说
//
//  Created by JiangDing on 15/11/29.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JDUserInfoParam, JDUserInfoResult, JDUnReadCountParam, JDUnReadCountResult;

@interface JDUserTool : NSObject


/**
 *  首页获取用户信息的业务方法
 *
 *  @param params  params 请求参数
 *  @param success success 请求成功后返回的block
 *  @param failure failure 请求失败返回的block
 */
+ (void)getUserInfoWithParam:(JDUserInfoParam *)params success:(void (^)(JDUserInfoResult *result))success failure:(void (^)(NSError *error))failure;


/**
 *  获取用户未读数目的业务方法
 *
 *  @param params  params 请求参数
 *  @param success success 请求成功后返回的block
 *  @param failure failure 请求失败返回的block
 */
+ (void)getUnReadCountWithParam:(JDUnReadCountParam *)params success:(void (^)(JDUnReadCountResult *result))success failure:(void (^)(NSError *error))failure;
@end
