//
//  JDStatus.h
//  丁丁说
//
//  Created by JiangDing on 15/11/24.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JDUser;

@interface JDStatus : NSObject

/** 	string 	微博创建时间 */
@property (nonatomic, copy) NSString *created_at;

/** 	string 	字符串型的微博ID */
@property (nonatomic, copy) NSString *idstr;

/** 	string 	微博信息内容 */
@property (nonatomic, copy) NSString *text;
/**     富文本  */
@property (nonatomic, copy) NSAttributedString *attrText;

/** 	string 	微博来源 */
@property (nonatomic, copy) NSString *source;

/**     object 微博用户信息  */
@property (nonatomic, strong) JDUser *user;

/**     object 转发微博  */
@property (nonatomic, strong) JDStatus *retweeted_status;

/** 	int 	转发数 */
@property (nonatomic, assign) int reposts_count;

/** 	 int 	评论数 */
@property (nonatomic, assign) int comments_count;

/** 	 int 	表态数 */
@property (nonatomic, assign) int attitudes_count;

/**  多图地址, 没有图就是空  */
@property (nonatomic, strong) NSArray *pic_urls;

/** 是否是转发微博 */
@property (nonatomic, assign, getter = isRetweeted) BOOL retweeted;

/** 是否是显示在微博正文里 */
@property (nonatomic, assign, getter = isDetail) BOOL detail;

//// 初始化方法
//- (instancetype)initWithDict:(NSDictionary *)dict;
//+ (instancetype)statusWithDict:(NSDictionary *)dict;

@end
