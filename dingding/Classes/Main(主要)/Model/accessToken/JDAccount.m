//
//  JDAccount.m
//  丁丁说
//
//  Created by JiangDing on 15/11/23.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDAccount.h"

@implementation JDAccount


- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.access_token = dict[@"access_token"];
        self.expires_in = dict[@"expires_in"];
        self.uid = dict[@"uid"];
        
        // 当前时间
        NSDate *now = [NSDate date];
        
        // 刚登陆之后多少时间失效, 默认设置为7天
        double time = 60 * 60 * 24 * 7;
        
        self.expires_time = [now dateByAddingTimeInterval:time];

    }
    return self;
}

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

/**
 * 告诉归档怎么写入
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];

    [encoder encodeObject:self.expires_time forKey:@"expires_time"];
    
    [encoder encodeObject:self.name forKey:@"name"];
}

/**
 *  告诉归档怎么解析
 */
- (instancetype)initWithCoder:(NSCoder *)Decoder
{
    self = [super init];
    if (self) {
        self.access_token = [Decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [Decoder decodeObjectForKey:@"expires_in"];
        self.uid = [Decoder decodeObjectForKey:@"uid"];
        
        self.expires_time = [Decoder decodeObjectForKey:@"expires_time"];
        
        self.name = [Decoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
