//
//  JDComment.m
//  丁丁说
//
//  Created by JiangDing on 15/12/9.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDComment.h"
#import "RegexKitLite.h"
#import "JDRegexResult.h"
#import "JDEmotion.h"
#import "JDEmotionTool.h"
#import "JDEmotionAttachment.h"

@implementation JDComment


- (void)setText:(NSString *)text
{
    _text = text;
    
    
    self.attrText = [self attributedStringWithText:self.text];
}


- (NSAttributedString *)attributedStringWithText:(NSString *)text
{
    //1. 匹配字符串
    NSArray *regexResults = [self regexResultWithText:text];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    //2. 处理超链接, @,话题
    [regexResults enumerateObjectsUsingBlock:^(JDRegexResult *result, NSUInteger idx, BOOL *stop) {
        // 如果是表情就显示表情
        JDEmotion *emoti = nil;
        if (result.isEmotion) {
            // 获取emotion
            emoti = [JDEmotionTool emotionWithText:result.string];
        }
        
        // 如果获取到了emotion
        if (emoti) {
            JDEmotionAttachment *attachment = [[JDEmotionAttachment alloc] init];
            
            // 设置
            attachment.emotion = emoti;
            
            attachment.bounds = CGRectMake(0, -3, JDStatusTextFont.lineHeight, JDStatusTextFont.lineHeight);
            
            // 附件包装成富文本
            NSAttributedString *arrt = [NSAttributedString attributedStringWithAttachment:attachment];
            
            // 添加
            [attributedText appendAttributedString:arrt];
            
        }else{ // 处理文字
            
            NSMutableAttributedString *subStr = [[NSMutableAttributedString alloc] initWithString:result.string];
            
            // 匹配#话题#
            NSString *trendRegex = @"#[a-zA-Z0-9\\u4e00-\\u9fa5]+#";
            [result.string enumerateStringsMatchedByRegex:trendRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                
                [subStr addAttribute:NSForegroundColorAttributeName value:JDStatusHightColor range:*capturedRanges];
                [subStr addAttribute:JDLink value:*capturedStrings range:*capturedRanges];
                
            }];
            
            // 匹配@提到
            NSString *mentionRegex = @"@[a-zA-Z0-9\\u4e00-\\u9fa5\\-_]+";
            [result.string enumerateStringsMatchedByRegex:mentionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [subStr addAttribute:NSForegroundColorAttributeName value:JDStatusHightColor range:*capturedRanges];
                [subStr addAttribute:JDLink value:*capturedStrings range:*capturedRanges];
            }];
            
            // 匹配超链接
            NSString *httpRegex = @"http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?";
            [result.string enumerateStringsMatchedByRegex:httpRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [subStr addAttribute:NSForegroundColorAttributeName value:JDStatusHightColor range:*capturedRanges];
                [subStr addAttribute:JDLink value:*capturedStrings range:*capturedRanges];
            }];
            
            // 添加
            [attributedText appendAttributedString:subStr];
            
        }
    }];
    
    // 设置字体
    [attributedText addAttribute:NSFontAttributeName value:JDStatusTextFont range:NSMakeRange(0, attributedText.length)];
    
    // 返回数据
    return  attributedText;
}



/**
 截取文本排列顺序
 */
- (NSArray *)regexResultWithText:(NSString *)text
{
    // 1. 用来存放所有结果
    NSMutableArray *regexResults = [NSMutableArray array];
    
    // 匹配表情
    NSString *emotionRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    [text enumerateStringsMatchedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        JDRegexResult *regexResult = [[JDRegexResult alloc] init];
        regexResult.string = *capturedStrings;
        regexResult.range = *capturedRanges;
        regexResult.emotion = YES;
        
        // 添加
        [regexResults addObject:regexResult];
        
    }];
    
    // 匹配非表情
    [text enumerateStringsSeparatedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        JDRegexResult *regexResult = [[JDRegexResult alloc] init];
        regexResult.string = *capturedStrings;
        regexResult.range = *capturedRanges;
        regexResult.emotion = NO;
        
        // 添加
        [regexResults addObject:regexResult];
    }];
    
    // 2. 遍历排列顺序
    [regexResults sortUsingComparator:^NSComparisonResult(JDRegexResult *r1, JDRegexResult *r2) {
        NSInteger loc1 = r1.range.location;
        NSInteger loc2 = r2.range.location;
        if (loc1 > loc2) {
            return NSOrderedDescending; // 降序
        }else if (loc1 < loc2){
            return NSOrderedAscending;
        }else{
            return NSOrderedSame;
        }
    }];
    
    return regexResults;
    
}


@end
