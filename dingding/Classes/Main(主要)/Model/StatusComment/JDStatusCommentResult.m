//
//  JDStatusCommentResult.m
//  丁丁说
//
//  Created by JiangDing on 15/12/9.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDStatusCommentResult.h"
#import "MJExtension.h"
#import "JDComment.h"

@implementation JDStatusCommentResult

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"comments" : [JDComment class]};
}

@end
