//
//  JDHomeStatueResult.m
//  丁丁说
//
//  Created by JiangDing on 15/11/26.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDHomeStatusResult.h"
#import "MJExtension.h"
#import "JDStatus.h"

@implementation JDHomeStatusResult

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"statuses" : [JDStatus class]};
}

@end
