//
//  JDHomeStatueResult.h
//  丁丁说
//
//  Created by JiangDing on 15/11/26.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JDStatus;

@interface JDHomeStatusResult : NSObject

/** 微博数组 */
@property (nonatomic, strong) NSArray *statuses;

/** 近期微博总数 */
@property (nonatomic, assign) NSNumber *total_number;

@end
