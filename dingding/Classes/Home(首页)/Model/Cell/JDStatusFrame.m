//
//  JDStatusFrame.m
//  丁丁说
//
//  Created by JiangDing on 15/11/29.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDStatusFrame.h"
#import "JDDetaiFrame.h"

@implementation JDStatusFrame

// 设置数据
- (void)setStatus:(JDStatus *)status
{
    _status = status;
    
    // 1. detai
    JDDetaiFrame *detailFrame = [[JDDetaiFrame alloc] init];
    detailFrame.status = status;
    self.detailFrame = detailFrame;

    // 2. tab
    CGFloat tabX = 0;
    CGFloat tabY = CGRectGetMaxY(self.detailFrame.rect);
    CGFloat tabW = [UIScreen mainScreen].bounds.size.width;
    CGFloat tabH = 35;
    self.tabBarFrame = CGRectMake(tabX, tabY, tabW, tabH);
    
    
    // 计算cellHeight
    self.cellHeight = CGRectGetMaxY(self.tabBarFrame) + JDMarin10;
}

@end
