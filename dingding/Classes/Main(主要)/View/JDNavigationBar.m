//
//  JDNavigationBar.m
//  丁丁说
//
//  Created by JiangDing on 15/12/8.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDNavigationBar.h"

@implementation JDNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// 布局子控件位置
- (void)layoutSubviews
{
    [super layoutSubviews];
 
    // 重新布局按钮位置
    for (UIButton *btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]]){
            if (btn.x  < self.width * 0.2) { // 左边
                btn.x = btn.titleLabel.text ? 0 : 10;
            }else if(btn.x > self.width * 0.8) { // 右边
                btn.x = btn.titleLabel.text ? (self.width - btn.width) : (self.width - btn.width - 10);
            }
        }
    }
}



@end
