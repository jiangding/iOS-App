//
//  JDUnReadCountResult.m
//  丁丁说
//
//  Created by JiangDing on 15/11/29.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDUnReadCountResult.h"

@implementation JDUnReadCountResult

- (int)messageCount
{
    return self.cmt + self.dm + self.mention_cmt + self.mention_status;
}


- (int)totalCount
{
    return self.messageCount + self.follower + self.status;
}

@end
