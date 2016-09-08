//
//  JDDetaiFrame.m
//  丁丁说
//
//  Created by JiangDing on 15/11/29.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDDetaiFrame.h"
#import "JDMeFrame.h"
#import "JDOtherFrame.h"

#import "JDStatus.h"

@interface JDDetaiFrame()

@end

@implementation JDDetaiFrame

// 设置数据

- (void)setStatus:(JDStatus *)status
{
    _status = status;
    
    // 1. meFrame
    JDMeFrame *meFrame = [[JDMeFrame alloc] init];
    meFrame.status = status;
    self.meFrame = meFrame;
    
    CGFloat h = 0;
    // 如果存在转发微博才设置
    if (status.retweeted_status) {
        // 2. otherFrame
        JDOtherFrame *otherFrame = [[JDOtherFrame alloc] init];
        otherFrame.retweetedStatus = status.retweeted_status;
        self.otherFrame = otherFrame;
        
        CGRect frame = self.otherFrame.rect;
        frame.origin.y  = CGRectGetMaxY(self.meFrame.rect);
        self.otherFrame.rect = frame;
 
        h = CGRectGetMaxY(self.otherFrame.rect);
    }else{
        h = CGRectGetMaxY(self.meFrame.rect);
    }

    self.rect = CGRectMake(0, 0, JDScreenWidth, h);
}


@end
