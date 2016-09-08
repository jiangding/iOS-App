//
//  JDSendCommentParam.h
//  丁丁说
//
//  Created by JiangDing on 15/12/13.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDSendCommentParam : NSObject

/** string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。 */
@property (nonatomic, copy) NSString *access_token;

/** string	评论内容，必须做URLencode，内容不超过140个汉字。 */
@property (nonatomic, copy) NSString *comment;

/** int64	需要评论的微博ID。 */
@property (nonatomic, copy) NSString *id;

/** string	开发者上报的操作用户真实IP，形如：211.156.0.1。 */
@property (nonatomic, copy) NSString *rip;

/** 当评论转发微博时，是否评论给原微博，0：否、1：是，默认为0 */
@property (nonatomic, assign) int comment_ori;

@end
