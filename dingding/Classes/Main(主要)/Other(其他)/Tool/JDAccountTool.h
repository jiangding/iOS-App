//
//  JDAccountTool.h
//  丁丁说
//
//  Created by JiangDing on 15/11/23.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JDAccount, JDAccessTokenParam;

@interface JDAccountTool : NSObject

/**
 *  获取登陆用户信息
 */
+ (JDAccount *)account;

/**
 获取access_token
 */
+ (NSString *)access_token;

/**
 *  写入登陆成功的数据到文档
 */
+ (void)save:(JDAccount *)accountMod;


/**
 *  获取accessToken的业务方法
 *
 *  @param params  params 请求参数
 *  @param success success 请求成功后返回的block
 *  @param failure failure 请求失败返回的block
 */
+ (void)postAccessTokenWithParam:(JDAccessTokenParam *)params success:(void (^)(JDAccount *account))success failure:(void (^)(NSError *error))failure;


@end
