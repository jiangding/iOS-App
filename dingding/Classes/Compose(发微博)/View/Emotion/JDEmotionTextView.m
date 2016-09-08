//
//  JDEmotionTextView.m
//  丁丁说
//
//  Created by JiangDing on 15/12/4.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDEmotionTextView.h"
#import "JDEmotionAttachment.h"

@implementation JDEmotionTextView


- (void)appendEmotion:(JDEmotion *)emotion
{

    // 判断
    if (emotion.emoji) {  // emoji
        
        [self insertText:emotion.emoji];
        
    }else{ // 拼接图片表情
        
        // 1. 获取之前的属性文本
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        
        // 2. 拼接
        JDEmotionAttachment *attach = [JDEmotionAttachment attach];
        // 设置数据
        attach.emotion =  emotion;
        // 设置frame
        CGFloat imageW = self.font.lineHeight;
        attach.bounds = CGRectMake(0, -3, imageW, imageW);

        NSAttributedString *subAttrStr = [NSAttributedString attributedStringWithAttachment:attach];
 
        // 记录当前光标为位置
        NSInteger indexRange = self.selectedRange.location;
        
        // 插入到当前光标位置
        [attrString insertAttributedString:subAttrStr atIndex:self.selectedRange.location];
        
        // 设置attr字体和普通文本一样
        [attrString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attrString.length)];
 
        // 3. 重新赋值属性文本(此时光标跳转到末尾)
        self.attributedText = attrString;
        
        // 4. 重新赋值光标到当前位置
        self.selectedRange = NSMakeRange(indexRange + 1, 0);
        
    }
}

- (NSString *)realText
{
    // 1.自定义字符串
    NSMutableString *string = [NSMutableString string];
    
    // 2.遍历富文本里面的所有内容
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        
        JDEmotionAttachment *attach = attrs[@"NSAttachment"];
        // 如果有
        if (attach) {
            [string appendString:attach.emotion.chs];
        }else{
            // 截取普通文本数据
            NSString *subStr = [self.attributedText attributedSubstringFromRange:range].string;
            
            [string appendString:subStr];
        }
        
    }];
    
    return string;
    
}

@end
