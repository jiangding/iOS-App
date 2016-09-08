//
//  JDStatusCommentResult.h
//  丁丁说
//
//  Created by JiangDing on 15/12/9.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JDComment;


@interface JDStatusCommentResult : NSObject

/** 评论数组 */
@property (nonatomic, strong) NSArray *comments;

/** 评论总数 */
@property (nonatomic, assign) int total_number;
@end
