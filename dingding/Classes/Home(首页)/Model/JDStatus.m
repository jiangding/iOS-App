//
//  JDStatus.m
//  丁丁说
//
//  Created by JiangDing on 15/11/24.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDStatus.h"
#import "JDUser.h"
#import "JDPhoto.h"
#import "MJExtension.h"
#import "JDRegexResult.h"
#import "RegexKitLite.h"
#import "JDEmotionAttachment.h"
#import "JDEmotionTool.h"

#import "NSDate+JD.h"

@implementation JDStatus

// 指定数组中 用什么模型代替
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"pic_urls" : [JDPhoto class]};
}

//- (instancetype)initWithDict:(NSDictionary *)dict
//{
//    self = [super self];
//    if (self) {
//        self.created_at = dict[@"created_at"];
//        self.idstr = dict[@"idstr"];
//        self.text = dict[@"text"];
//        self.source = dict[@"source"];
//        self.reposts_count = dict[@"reposts_count"];
//        self.comments_count = dict[@"comments_count"];
//        self.attitudes_count = dict[@"attitudes_count"];
//        
//        // 用户
//        self.user = [JDUser userWithDict:dict[@"user"]];
//        // 转发微博
//        NSDictionary *retweetedDict = dict[@"retweeted_status"];
//        if (retweetedDict) {
//            self.retweeted_status = [JDStatus statusWithDict:retweetedDict];
//        }
//    }
//    return self;
//}
//
//+ (instancetype)statusWithDict:(NSDictionary *)dict
//{
//    return [[self alloc] initWithDict:dict];
//}

// 处理时间
- (NSString *)created_at
{

    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
#warning  设置语言时区, 不设置这个真机改了语言就会发生错误
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [fmt setLocale:locale];
    
    // 获得微博发布的具体时间
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    // 判断是否为今年
    if (createDate.isThisYear) {
        if (createDate.isToday) { // 今天
            NSDateComponents *cmps = [createDate deltaWithNow];
            if (cmps.hour >= 1) { // 至少是1小时前发的
                return [NSString stringWithFormat:@"%ld小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1~59分钟之前发的
                return [NSString stringWithFormat:@"%ld分钟前", cmps.minute];
            } else { // 1分钟内发的
                return @"刚刚";
            }
        } else if (createDate.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else { // 至少是前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createDate];
    }

}



// 截取来自
- (void)setSource:(NSString *)source
{
    
    if (source == nil) return;
    
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    
    // 开始截取
    NSString *subSourse = [source substringWithRange:range];
    
    _source = [NSString stringWithFormat:@"来自%@", subSourse];
 
}

- (void)setText:(NSString *)text
{
    _text = [text copy];
    
    [self createAttributedText];
}

- (void)setUser:(JDUser *)user
{
    _user = user;
    
    [self createAttributedText];
}

- (void)setRetweeted_status:(JDStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    
    self.retweeted = NO;
    retweeted_status.retweeted = YES;
}

- (void)setRetweeted:(BOOL)retweeted
{
    _retweeted = retweeted;
    
    [self createAttributedText];
}

- (void)createAttributedText
{
    if (self.text == nil || self.user == nil) return;
    
    // 若果是转发微博
    if (self.retweeted) {
        NSString *totalText = [NSString stringWithFormat:@"@%@ : %@", self.user.name, self.text];
        NSAttributedString *attributedString = [self attributedStringWithText:totalText];
        self.attrText = attributedString;
    } else {
        self.attrText = [self attributedStringWithText:self.text];
    }
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
