//
//  JDAccountTool.m
//  丁丁说
//
//  Created by JiangDing on 15/11/23.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDAccountTool.h"
#import "JDAccount.h"
#import "JDHttpTool.h"
#import "MJExtension.h"
#import "JDAccessTokenParam.h"

#define AccountFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"account.data"]

@implementation JDAccountTool

+ (JDAccount *)account
{
    // 解档
    JDAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountFilePath];
    
    // 判断是否过期
    // 当前时间
    NSDate *now = [NSDate date];
    // 如果现在时间 > 过期时间
 
    if ([now compare:account.expires_time] != NSOrderedAscending) {
        // 过期
        account = nil;
    }
 
    return account;
}

/**
 *  写入登陆成功的数据到文档
 */
+ (void)save:(JDAccount *)accountMod
{
    // 归档处理
    [NSKeyedArchiver archiveRootObject:accountMod toFile:AccountFilePath];
}

// 获取access_token
+ (NSString *)access_token
{
    return [JDAccountTool account].access_token;
}



+ (void)postAccessTokenWithParam:(JDAccessTokenParam *)params success:(void (^)(JDAccount *))success failure:(void (^)(NSError *))failure
{
    [JDHttpTool post:@"https://api.weibo.com/oauth2/access_token" parameters:params.mj_keyValues success:^(id responseObject) {
        
        if (success) {
            JDAccount *account = [JDAccount accountWithDict:responseObject];
            success(account);
        }
    } failure:^(NSError *error) {
        /**
         *  AFNetWork内部加上: unacceptable content-type: text/plain,
         */
        if (failure) {
            failure(error);
        }
    }];
}
@end
