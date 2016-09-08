//
//  JDUserFansResult.m
//  丁丁说
//
//  Created by JiangDing on 15/12/15.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDUserFansResult.h"
#import "MJExtension.h"
#import "JDUser.h"

@implementation JDUserFansResult

+ (NSDictionary *)mj_objectClassInArray
{
    return @{ @"users" : [JDUser class]};
}
@end
