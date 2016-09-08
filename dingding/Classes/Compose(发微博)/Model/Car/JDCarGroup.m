//
//  JDCarGroup.m
//  丁丁说
//
//  Created by JiangDing on 15/12/15.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDCarGroup.h"
#import "JDCar.h"
#import "MJExtension.h"

@implementation JDCarGroup

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"cars" : [JDCar class]};
}

@end
