//
//  JDEmotionTool.h
//  丁丁说
//
//  Created by JiangDing on 15/12/4.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JDEmotion;

@interface JDEmotionTool : NSObject

/**
 *  默认表情
 */
+ (NSArray *)defaultEmotions;
/**
 *  emoji表情
 */
+ (NSArray *)emojiEmotions;
/**
 *  浪小花表情
 */
+ (NSArray *)lxhEmotions;
/**
 *  最近表情
 */
+ (NSArray *)recentEmotions;

// 添加最近
+ (void) addEmotionRecent:(JDEmotion *)emotion;

/** 根据文字找emotion */
+ (JDEmotion *)emotionWithText:(NSString *)string;

@end
