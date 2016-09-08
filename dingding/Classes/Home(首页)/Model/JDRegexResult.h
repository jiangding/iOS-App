//
//  JDRegexResult.h
//  丁丁说
//
//  Created by JiangDing on 15/12/4.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDRegexResult : NSObject

/**
 *  匹配字符串
 */
@property (nonatomic, copy) NSString *string;

/**
 *  匹配范围
 */
@property (nonatomic, assign) NSRange range;

/**
 *  是否是emotion
 */
@property (nonatomic, assign, getter=isEmotion) BOOL emotion;

@end
