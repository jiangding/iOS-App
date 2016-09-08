//
//  JDDetailBottomToolBar.m
//  丁丁说
//
//  Created by JiangDing on 15/12/8.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDDetailBottomToolBar.h"

@implementation JDDetailBottomToolBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
 
        // 添加三个按钮
       [self addButtonWithImage:@"timeline_icon_retweet" title:@"转发"];
       [self addButtonWithImage:@"timeline_icon_comment" title:@"评论"];
       [self addButtonWithImage:@"timeline_icon_unlike" title:@"赞"];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage strectchImageWithNamed:@"statusdetail_toolbar_background"] drawInRect:rect];
}

/**
 *  添加按钮方法
 */
- (UIButton *)addButtonWithImage:(NSString *)icon title:(NSString *)title
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage strectchImageWithNamed:@"common_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = JDStatusToolFont;
    btn.adjustsImageWhenHighlighted = NO;
    
    
    [self addSubview:btn];
   // [self.buttons addObject:btn];
    
    return btn;
}

// 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];

    int count = (int)self.subviews.count;
    
    CGFloat width = JDScreenWidth / count;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.width = width;
        btn.height = 44;
        btn.y = 0;
        btn.x = width * i;
    }
}


@end
