//
//  JDEmotion.m
//  丁丁说
//
//  Created by JiangDing on 15/12/3.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDEmotion.h"
#import "NSString+Emoji.h"

@implementation JDEmotion

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@ - %@", self.chs, self.png, self.code];
}

- (void)setCode:(NSString *)code
{
    _code = [code copy];
    
    // 如果最近的非emoji就不执行
    if (code == nil) return;
    
    self.emoji = [NSString emojiWithStringCode:code];
}

// 如何写入
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.chs forKey:@"chs"];
    [aCoder encodeObject:self.png forKey:@"png"];
    [aCoder encodeObject:self.code forKey:@"code"];
    [aCoder encodeObject:self.founder forKey:@"founder"];
}

// 如何解析
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.chs = [coder decodeObjectForKey:@"chs"];
        self.png = [coder decodeObjectForKey:@"png"];
        self.code = [coder decodeObjectForKey:@"code"];
        self.founder = [coder decodeObjectForKey:@"founder"];
    }
    return self;
}

// 重写isEque方法, 改变系统默认通过地址判断是否相同!!!, 解决从沙河中取出的和内存中的不是一个世界的问题
- (BOOL)isEqual:(JDEmotion *)otherEmotion
{
    if (self.code) { //emoji
        return [self.code isEqualToString:otherEmotion.code];
    }else{ // 图片
        return [self.chs isEqualToString:otherEmotion.chs] && [self.png isEqualToString:otherEmotion.png];
    }
}

@end
