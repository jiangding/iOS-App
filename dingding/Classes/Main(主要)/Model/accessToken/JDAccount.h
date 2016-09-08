//
//  JDAccount.h
//  丁丁说
//
//  Created by JiangDing on 15/11/23.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDAccount : NSObject <NSCoding>

/** 用户的access_token */
@property (nonatomic, copy) NSString *access_token;

/** access_token 生命周期, 单位是秒 */
@property (nonatomic, copy) NSString *expires_in;

/** 用户唯一标识 */
@property (nonatomic, copy) NSString *uid;

/** 登陆有效时间 */
@property (nonatomic, strong) NSDate *expires_time;

/** 用户名 */
@property (nonatomic, copy) NSString *name;

///**
// *  初始化
// */
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
