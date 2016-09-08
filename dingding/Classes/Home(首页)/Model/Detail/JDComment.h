//
//  JDComment.h
//  丁丁说
//
//  Created by JiangDing on 15/12/9.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JDUser, JDStatus, JDComment;


@interface JDComment : NSObject
/** string	评论创建时间 */
@property (nonatomic, copy) NSString *created_at;

/** string	评论的内容 */
@property (nonatomic, copy) NSString *text;

/** 富文本 */
@property (nonatomic, copy) NSAttributedString *attrText;

/** object	评论作者的用户信息字段 详细  */
@property (nonatomic, strong) JDUser *user;

/** object	评论的微博信息字段 详细  */
@property (nonatomic, strong) JDStatus *status;

/** 	string 	微博来源*/
@property (nonatomic, copy) NSString *source;

/** string	评论的MID */
@property (nonatomic, copy) NSString *mid;

/** string	字符串型的评论ID */
@property (nonatomic, copy) NSString *idstr;

/** object 评论来源评论，当本评论属于对另一评论的回复时返回此字段 */
@property (nonatomic, strong) JDComment *reply_comment;

@end
