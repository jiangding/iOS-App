//
//  JDUser.h
//  丁丁说
//
//  Created by JiangDing on 15/11/24.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDUser : NSObject

/**  用户姓名 */
@property (nonatomic, copy) NSString *name;

/**  用户头像地址 小图 */
@property (nonatomic, copy) NSString *profile_image_url;
/**  用户头像地址 大图 */
@property (nonatomic, copy) NSString *avatar_large;

/** 用户个人描述 */
@property (nonatomic, copy) NSString *desc;

/** 会员类型 */
@property (nonatomic, assign) int mbtype;

/** 会员等级 */
@property (nonatomic, assign) int mbrank;

/** 会员 */
@property (nonatomic, assign, getter=isVip, readonly) BOOL vip;

//// 初始化
//- (instancetype)initWithDict:(NSDictionary *)dict;
//+ (instancetype)userWithDict:(NSDictionary *)dict;

@end
