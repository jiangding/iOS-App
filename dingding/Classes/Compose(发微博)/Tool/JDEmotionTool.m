//
//  JDEmotionTool.m
//  丁丁说
//
//  Created by JiangDing on 15/12/4.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDEmotionTool.h"
#import "JDEmotion.h"
#import "MJExtension.h"

#define JDRecentFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recent_emotions.data"]

@implementation JDEmotionTool
/** 默认表情 */
static NSArray *_defaultEmotions;
/** emoji表情 */
static NSArray *_emojiEmotions;
/** 浪小花表情 */
static NSArray *_lxhEmotions;
/** 最近表情 */
static NSMutableArray *_recentEmotions;

+ (NSArray *)defaultEmotions
{
    if (_defaultEmotions == nil) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defaultEmotions = [JDEmotion mj_objectArrayWithFile:plist];
        
        // 设置目录, 遍历数组中的子元素都调用这个方法
        [_defaultEmotions makeObjectsPerformSelector:@selector(setFounder:) withObject:@"EmotionIcons/default"];
    }
    return _defaultEmotions;
}

+ (NSArray *)emojiEmotions
{
    if (_emojiEmotions == nil) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiEmotions = [JDEmotion mj_objectArrayWithFile:plist];
        
        // 设置目录, 遍历数组中的子元素都调用这个方法
        //[self.emojis makeObjectsPerformSelector:@selector(setFounder:) withObject:@"EmotionIcons/emoji"];
    }
    return _emojiEmotions;
}

+ (NSArray *)lxhEmotions
{
    if (_lxhEmotions == nil) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhEmotions = [JDEmotion mj_objectArrayWithFile:plist];
        
        // 设置目录, 遍历数组中的子元素都调用这个方法
        [_lxhEmotions makeObjectsPerformSelector:@selector(setFounder:) withObject:@"EmotionIcons/lxh"];
    }
    return _lxhEmotions;
}

+ (NSArray *)recentEmotions
{
    if (_recentEmotions == nil) {
        // 去沙河中取存储的最近表情数据
        _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:JDRecentFilepath];
        
        
        // 如果沙河中没有数据
        if (_recentEmotions == nil) {
            _recentEmotions = [NSMutableArray array];
        }
    }
    return _recentEmotions;
}

// 添加最近
+ (void) addEmotionRecent:(JDEmotion *)emotion
{
    // 重新获取沙盒数据
    [self recentEmotions];
    
    // 防止有相同的emotion就删除，先删除后加
    [_recentEmotions removeObject:emotion];
    
    // 把最新添加的插入到数组的开头
    [_recentEmotions insertObject:emotion atIndex:0];
    
    // 保存到沙盒中
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:JDRecentFilepath];
 
}


+ (JDEmotion *)emotionWithText:(NSString *)string
{
    // 如果文字没有
    if (string == nil) return nil;
    
    __block JDEmotion *foundEmotion = nil;
    
    // 从默认表情中去找
    [[self defaultEmotions] enumerateObjectsUsingBlock:^(JDEmotion *emotion, NSUInteger idx, BOOL *stop) {
        // 如果相等
        if ([string isEqualToString:emotion.chs]) {
            foundEmotion = emotion;
            *stop = YES;
        }
    }];
    
    // 从浪小花中找
    [[self lxhEmotions] enumerateObjectsUsingBlock:^(JDEmotion *emotion, NSUInteger idx, BOOL *stop) {
        // 如果相等
        if ([string isEqualToString:emotion.chs]) {
            foundEmotion = emotion;
            *stop = YES;
        }
    }];
    
    return foundEmotion;
}


@end
