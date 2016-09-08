//
//  NSDate+JD.h
//  丁丁说
//
//  Created by JiangDing on 15/11/30.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JD)


/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;


/**
 *  返回时间
 */
+ (NSString *)dateFormat:(NSString *)str;
@end
