//
//  JDUserFansResult.h
//  丁丁说
//
//  Created by JiangDing on 15/12/15.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JDUser;

@interface JDUserFansResult : NSObject

/** 存储装用户的数组 */
@property (nonatomic, strong) NSArray *users;

/** 下一个游标 */
@property (nonatomic, assign) int next_cursor;
/** 上一个游标 */
@property (nonatomic, assign) int previous_cursor;

/** 总数 */
@property (nonatomic, assign) int total_number;

@end
