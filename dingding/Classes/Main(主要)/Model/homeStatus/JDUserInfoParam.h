//
//  JDUserInfoParam.h
//  丁丁说
//
//  Created by JiangDing on 15/11/29.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDUserInfoParam : NSObject
/** 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。 */
@property (nonatomic , copy) NSString *access_token;

/** 需要查询的用户id */
@property (nonatomic, strong) NSString *uid;

@end
