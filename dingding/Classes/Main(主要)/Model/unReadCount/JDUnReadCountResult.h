//
//  JDUnReadCountResult.h
//  丁丁说
//
//  Created by JiangDing on 15/11/29.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDUnReadCountResult : NSObject
/** 新微博未读数 */
@property (nonatomic, assign) int status;

/** 新粉丝数 */
@property (nonatomic, assign) int follower;

/** 新评论数 */
@property (nonatomic, assign) int cmt;

/** 新私信数  */
@property (nonatomic, assign) int dm;

/** 新提及我的微博数 */
@property (nonatomic, assign) int mention_cmt;

/** 新提及我的评论数 */
@property (nonatomic, assign) int mention_status;

/** 消息总数  */
@property (nonatomic, assign) int messageCount;

/** 总数 */
@property (nonatomic, assign) int totalCount;


@end
