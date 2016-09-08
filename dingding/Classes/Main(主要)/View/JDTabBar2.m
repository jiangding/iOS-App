//
//  JDTabBar2.m
//  丁丁说
//
//  Created by JiangDing on 15/11/21.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDTabBar2.h"
#import "JDTabButton.h"

@interface JDTabBar2()

@property (nonatomic, strong) JDTabButton *selectedBtn;

@end

@implementation JDTabBar2

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
        // 添加几个按钮
        // 首页
        [self addOneTabBarItemWithIcon:@"tabbar_home_os7" selectedIcon:@"tabbar_home_selected_os7" title:@"首页" ];
        
        // 消息
        [self addOneTabBarItemWithIcon:@"tabbar_message_center_os7" selectedIcon:@"tabbar_message_center_selected_os7" title:@"消息"];
        
        // 发现
        [self addOneTabBarItemWithIcon:@"tabbar_discover_os7" selectedIcon:@"tabbar_discover_selected_os7" title:@"发现"];
        
        // 我的
        [self addOneTabBarItemWithIcon:@"tabbar_profile_os7" selectedIcon:@"tabbar_profile_selected_os7" title:@"我的"];
        
    }
    return self;
}

// 单个按钮添加
- (void)addOneTabBarItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon title:(NSString *)title 
{
    JDTabButton *btn = [[JDTabButton alloc] init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedIcon] forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(tabBarClick:) forControlEvents:UIControlEventTouchDown];
    
    btn.tag = self.subviews.count;
    
    if (btn.tag == 0) {
        [self tabBarClick:btn];
    }
  
    
    [self addSubview:btn];
}

/**
 *  tabBar点击
 */
- (void)tabBarClick:(JDTabButton *)tabBtn
{
    // 1. 取消上一个
    self.selectedBtn.selected = NO;
    
    tabBtn.selected = YES;
    
    self.selectedBtn = tabBtn;
    
    // 通知代理
    if ([self.myDelegate respondsToSelector:@selector(tabBar:didChangeIndex:)]) {
        [self.myDelegate tabBar:self didChangeIndex:tabBtn.tag];
    }

}

// 设置badge
- (void)setBadge:(NSString *)badge
{
    _badge = badge;
 
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = (int)self.subviews.count;
    
    CGFloat H = self.height;
    CGFloat W = self.width / count;
    
    int i = 0;
    for (JDTabButton *btn in self.subviews) {
        
        CGFloat X = i * W;
        
        btn.frame = CGRectMake(X, 0, W, H);
        
        i++;
    }
}



@end
