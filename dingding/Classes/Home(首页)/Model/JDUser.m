//
//  JDUser.m
//  丁丁说
//
//  Created by JiangDing on 15/11/24.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDUser.h"
#import "MJExtension.h"

@implementation JDUser

- (BOOL)isVip
{
    // 是会员
    return self.mbtype > 2;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{ @"desc" : @"description"};
}



//- (instancetype)initWithDict:(NSDictionary *)dict
//{
//    self = [super init];
//    if (self) {
//        self.name = dict[@"name"];
//        self.profile_image_url = dict[@"profile_image_url"];
//    }
//    return self;
//}
//
//+ (instancetype)userWithDict:(NSDictionary *)dict
//{
//    return [[self alloc] initWithDict:dict];
//}



@end
