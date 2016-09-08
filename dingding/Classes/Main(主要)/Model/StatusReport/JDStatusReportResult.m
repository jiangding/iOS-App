//
//  JDStatusReportResult.m
//  丁丁说
//
//  Created by JiangDing on 15/12/12.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDStatusReportResult.h"
#import "MJExtension.h"
#import "JDStatus.h"

@implementation JDStatusReportResult

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"reposts" : [JDStatus class]};
}

@end
