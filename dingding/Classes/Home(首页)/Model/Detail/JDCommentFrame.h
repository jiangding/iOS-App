//
//  JDCommentFrame.h
//  丁丁说
//
//  Created by JiangDing on 15/12/10.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JDComment;

@interface JDCommentFrame : NSObject

/** 头像F */
@property (nonatomic, assign) CGRect iconF;
/** 标题F */
@property (nonatomic, assign) CGRect titleF;
/** vipF */
@property (nonatomic, assign) CGRect vipF;
/** 时间F */
@property (nonatomic, assign) CGRect timeF;
/** 正文F */
@property (nonatomic, assign) CGRect textF;

@property (nonatomic, assign) CGRect zanF;

/** 每个评论的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/** 模型数据 */
@property (nonatomic, strong) JDComment *comment;

@end
