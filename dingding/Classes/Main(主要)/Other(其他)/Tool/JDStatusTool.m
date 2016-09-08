//
//  JDStatusTool.m
//  丁丁说
//
//  Created by JiangDing on 15/11/26.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDStatusTool.h"
#import "JDHomeStatusParam.h"
#import "JDHomeStatusResult.h"
#import "JDUserInfoParam.h"
#import "JDUserInfoResult.h"

#import "JDHttpTool.h"
#import "MJExtension.h"

#import "JDStatusCommentParam.h"
#import "JDStatusCommentResult.h"
#import "JDStatusReportParam.h"
#import "JDStatusReportResult.h"

#import "JDSendStatusResult.h"
#import "JDSendStatusParam.h"
#import "JDSendCommentParam.h"
#import "JDSendCommentResult.h"
#import "JDUserFansParam.h"
#import "JDUserFansResult.h"
#import "FMDB.h"
#import "JDStatus.h"

@implementation JDStatusTool

/**
 *  数据库实例
 */
static FMDatabase *_db;

+ (void)initialize
{
    // 1. 获得数据库文件路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [doc stringByAppendingPathComponent:@"status.sqlite"];
 
    // 2. 创建数据库
   _db = [FMDatabase databaseWithPath:filePath];
    
    // 3. 打开数据库
    if ([_db open]) {
        // 创表
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT  EXISTS t_home_status(id integer PRIMARY KEY AUTOINCREMENT, access_token text NOT NULL, status_idstr text NOT NULL, status_data blob NOT NULL);"];
        if (result) {
            JDLog(@"创表成功!");
        }else{
            JDLog(@"创表失败!");
        }
    }
}

+ (void)getHomeStatusWithParam:(JDHomeStatusParam *)params success:(void (^)(JDHomeStatusResult *))success failure:(void (^)(NSError *))failure
{
    //params.count = @3;
    
    // 1. 先从缓存中取出数据
    NSArray *cacheHomeStatusArr = [self cacheHomeStatusWithParams:params];
 
    if (cacheHomeStatusArr.count != 0) {
        JDHomeStatusResult *result = [[JDHomeStatusResult alloc] init];
        result.statuses = cacheHomeStatusArr;
        if (success) {
            JDLog(@"缓存");
            success(result);
        }
        
    }else{
        
        // 默认get为nil
        NSString *get = nil;
    
        if (params.statusType == kHomeStatusTypeMyStatus) {
            get = @"https://api.weibo.com/2/statuses/user_timeline.json";
            params.screen_name = @"明天先去";
        }else{
            get = @"https://api.weibo.com/2/statuses/home_timeline.json";
        }
        
        [JDHttpTool get:get parameters:params.mj_keyValues success:^(id responseObject) {
  
            // 获取到数据
            NSArray *statusArr = responseObject[@"statuses"];
            // 保存到缓存中
            [self insertHomeCacheStatus:statusArr accessToken:params.access_token];
            
            if (success) {
                JDLog(@"真实数据");
                JDHomeStatusResult *result = [JDHomeStatusResult mj_objectWithKeyValues:responseObject];
                success(result);
            }
            
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
            
        }];
    }

}

+ (void)getSingleStatusComment:(JDStatusCommentParam *)params success:(void (^)(JDStatusCommentResult *))success failure:(void (^)(NSError *))failure
{
    [JDHttpTool get:@"https://api.weibo.com/2/comments/show.json" parameters:params.mj_keyValues success:^(id responseObject) {
        if (success) {
            // 转为模型
            JDStatusCommentResult *result = [JDStatusCommentResult mj_objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:failure];
}


+ (void)getSingleStatusReport:(JDStatusReportParam *)params success:(void (^)(JDStatusReportResult *))success failure:(void (^)(NSError *))failure
{
    [JDHttpTool get:@"https://api.weibo.com/2/statuses/repost_timeline.json" parameters:params.mj_keyValues success:^(id responseObject) {
        //JDLog(@"reports:%@", responseObject);
        if (success) {
            // 转为模型
            JDStatusReportResult *result = [JDStatusReportResult mj_objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:failure];
}


 
+ (void)postSendStatusWithParam:(JDSendStatusParam *)params success:(void (^)(JDSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    [JDHttpTool post:@"https://api.weibo.com/2/statuses/update.json" parameters:params.mj_keyValues success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:failure];
}


+ (void)postSendStatusWithPictureParam:(JDSendStatusParam *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block success:(void (^)(JDSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    [JDHttpTool post:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params.mj_keyValues constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (block) {
            block(formData);
        }
    } success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postSendStatusCommentWithParam:(JDSendCommentParam *)parmas success:(void (^)(JDSendCommentResult *))success failure:(void (^)(NSError *))failure
{
    [JDHttpTool post:@"https://api.weibo.com/2/comments/create.json" parameters:parmas.mj_keyValues success:^(id responseObject) {
        if (success) {
            JDSendCommentResult *result = [JDSendCommentResult mj_objectWithKeyValues:responseObject];
            success(result);
        }
        
    } failure:failure];
}

+ (void)getUserFansWithParam:(JDUserFansParam *)params success:(void (^)(JDUserFansResult *))success failure:(void (^)(NSError *))failure
{

    [JDHttpTool get:@"https://api.weibo.com/2/friendships/followers.json" parameters:params.mj_keyValues success:^(id responseObject) {
        if (success) {
            JDUserFansResult *result = [JDUserFansResult mj_objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:failure];
}


#pragma mark - 首页数据缓存方法

/**
 *  从缓存中取出数据
 */
+ (NSArray *)cacheHomeStatusWithParams:(JDHomeStatusParam *)param
{
    // 1. 自定义数组
    NSMutableArray *statuses = [NSMutableArray array];
    
    // 2. 查询数据
    FMResultSet *resultSet = nil;
    if (param.since_id) {
        resultSet = [_db executeQuery:@"SELECT * FROM t_home_status WHERE access_token = ? AND status_idstr > ? ORDER BY status_idstr DESC LIMIT ?",param.access_token, param.since_id , param.count];
    }else if(param.max_id){
        resultSet = [_db executeQuery:@"SELECT * FROM t_home_status WHERE access_token = ? AND status_idstr <= ? ORDER BY status_idstr DESC LIMIT ?",param.access_token, param.max_id,  param.count];
    }else{
        resultSet = [_db executeQuery:@"SELECT * FROM t_home_status WHERE access_token = ? ORDER BY status_idstr DESC LIMIT ?", param.access_token ,param.count];
    }
 
    // 3.遍历查询结果
    while (resultSet.next) {
        NSData *data = [resultSet objectForColumnName:@"status_data"];
        
        // 反序列化
        NSDictionary *statusDict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        // 转化成模型
        JDStatus *status = [JDStatus mj_objectWithKeyValues:statusDict];
        
        [statuses addObject:status];
    }
    return statuses;
}

/**
 *  插入到缓存中去
 */
+ (void)insertHomeCacheStatus:(NSArray *)statuses accessToken:(NSString *)access_token
{
    // 循环插入数据
    for (NSDictionary *statusDict in statuses) {
        // 序列化
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:statusDict];
        [_db executeUpdate:@"INSERT INTO t_home_status (access_token, status_idstr, status_data) VALUES(?,?,?);", access_token, statusDict[@"idstr"], data];
    }
}

@end
