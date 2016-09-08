//
//  JDSendCommentResult.h
//  丁丁说
//
//  Created by JiangDing on 15/12/13.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JDUser,JDStatus;

@interface JDSendCommentResult : NSObject

/** int64	需要评论的微博ID。 */
@property (nonatomic, copy) NSString *idstr;

/** string	评论的内容 */
@property (nonatomic, copy) NSString *text;

/** object	评论作者的用户信息字段 详细 */
@property (nonatomic, strong) JDUser *user;
/** object 被评论的微博*/
@property (nonatomic, strong) JDStatus *status;

@end
