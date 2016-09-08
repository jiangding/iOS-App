//
//  JDBadgeView.m
//  丁丁说
//
//  Created by JiangDing on 15/11/21.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDBadgeView.h"

#define JDBadgeFont [UIFont systemFontOfSize:11.0]


@implementation JDBadgeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = NO;
        
        // 设置字体
        self.titleLabel.font = JDBadgeFont;
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        
        [self sizeToFit];
    }
    return self;
}


- (void)setBadge:(NSString *)badge
{
    _badge = badge;
    
    // 判断存在条件
    if (badge.length == 0 || [badge isEqualToString:@"0"]) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    
    // 获取文字的长度
    // CGSize size = [badge sizeWithFont:JDBadgeFont];
    CGSize size = [badge sizeWithAttributes:@{NSFontAttributeName:JDBadgeFont}];
    
    // 判断如果文字宽度大于整个view的宽度
    if (size.width > self.width) {
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }else{
        [self setImage:nil forState:UIControlStateNormal];
        [self setTitle:badge forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
    }
    
  
}



@end
