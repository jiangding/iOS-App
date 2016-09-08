//
//  JDUserTool.m
//  丁丁说
//
//  Created by JiangDing on 15/11/29.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDUserTool.h"
#import "JDUserInfoParam.h"
#import "JDUserInfoResult.h"

#import "JDAccessTokenParam.h"
#import "JDAccount.h"

#import "JDHttpTool.h"
#import "MJExtension.h"

#import "JDUnReadCountParam.h"
#import "JDUnReadCountResult.h"

@implementation JDUserTool

+ (void)getUserInfoWithParam:(JDUserInfoParam *)params success:(void (^)(JDUserInfoResult *))success failure:(void (^)(NSError *))failure
{
    [JDHttpTool get:@"https://api.weibo.com/2/users/show.json" parameters:params.mj_keyValues success:^(id responseObject) {
        
        if (success) {
            JDUserInfoResult *result = [JDUserInfoResult mj_objectWithKeyValues:responseObject];
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}



+ (void)getUnReadCountWithParam:(JDUnReadCountParam *)params success:(void (^)(JDUnReadCountResult *))success failure:(void (^)(NSError *))failure
{
    [JDHttpTool get:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params.mj_keyValues success:^(id responseObject) {
        if (success) {
            JDUnReadCountResult *result = [JDUnReadCountResult mj_objectWithKeyValues:responseObject];
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}



@end
