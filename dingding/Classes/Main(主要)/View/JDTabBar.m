//
//  JDTabBar.m
//  丁丁说
//
//  Created by JiangDing on 15/11/21.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDTabBar.h"
#import "JDTabButton.h"

@interface JDTabBar()

//@property (nonatomic, strong) NSMutableArray *buttons;
//
//@property (nonatomic, strong) JDTabButton *selectedBtn;

// 在tabBar中间添加一个按钮
@property (nonatomic, strong) UIButton *plusButton;

@end

@implementation JDTabBar

/**
 *  懒加载
 */
- (UIButton *)plusButton
{
    if (_plusButton == nil) {
        _plusButton = [[UIButton alloc] init];
        [_plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [_plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [_plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [_plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [_plusButton sizeToFit];
        [self addSubview:_plusButton];
        
        // 添加发微博
        [_plusButton addTarget:self action:@selector(plusButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _plusButton;
}

//- (NSMutableArray *)buttons
//{
//    if (_buttons == nil) {
//        _buttons = [NSMutableArray array];
//    }
//    return _buttons;
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
 
     
    }
    return self;
}


// 赋值
//- (void)setTabBarItems:(NSMutableArray *)tabBarItems
//{
//    _tabBarItems = tabBarItems;
//    
//    int count = (int)self.tabBarItems.count;
//    for (int i = 0; i < count; i++) {
//        UITabBarItem *item = self.tabBarItems[i];
//        
//        // 创建自定义按钮
//        JDTabButton *btn = [[JDTabButton alloc] init];
//        
//        // 设置属性
//        btn.item = item;
//        
//        // 添加btn方法
//        [btn addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchDown];
//        
//        btn.tag = self.buttons.count;
//        
//        // 选择第一个
//        if (btn.tag == 0) {
//            [self tabClick:btn];
//        }
// 
//        // 添加到数组中
//        [self.buttons addObject:btn];
//        
//        // 添加进去
//        [self addSubview:btn];
//    }
//}


/**
 *  点击按钮方法
 */
//- (void)tabClick:(JDTabButton *)tabBtn
//{
//    // 1. 取消上一个
//    self.selectedBtn.selected = NO;
//    
//    // 2. 选择
//    tabBtn.selected = YES;
//    
//    // 3. 重新赋值
//    self.selectedBtn = tabBtn;
//    
//    // 4. 代理
//    if ([self.myDelegate respondsToSelector:@selector(tabBar:didChangeIndex:)]) {
//        [self.myDelegate tabBar:self didChangeIndex:tabBtn.tag];
//    }
//}



/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];

    // 设置plusButton的frame
    [self setupPlusButtonFrame];
    
    // 设置所有tabbarButton的frame
    [self setupAllTabBarButtonsFrame];

}

/**
 *  设置所有plusButton的frame
 */
- (void)setupPlusButtonFrame
{
//    self.plusButton.size = self.plusButton.currentBackgroundImage.size;
    self.plusButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
}

/**
 *  设置所有tabbarButton的frame
 */
- (void)setupAllTabBarButtonsFrame
{
    int index = 0;
    
    //JDLog(@"%@", self.subviews);
    
    // 遍历所有的button
    for (UIView *tabBarButton in self.subviews) {
        // 如果不是UITabBarButton， 直接跳过
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        // 根据索引调整位置
        [self setupTabBarButtonFrame:tabBarButton atIndex:index];
        
        // 索引增加
        index++;
    }
}

/**
 *  设置某个按钮的frame
 *
 *  @param tabBarButton 需要设置的按钮
 *  @param index        按钮所在的索引
 */
- (void)setupTabBarButtonFrame:(UIView *)tabBarButton atIndex:(int)index
{
    // 计算button的尺寸
    CGFloat buttonW = self.width / (self.items.count + 1);
    CGFloat buttonH = self.height;
    
    tabBarButton.width = buttonW;
    tabBarButton.height = buttonH;
    if (index >= 2) {
        tabBarButton.x = buttonW * (index + 1);
    } else {
        tabBarButton.x = buttonW * index;
    }
    tabBarButton.y = 0;
}

/**
 *  点击发微博
 */
- (void)plusButtonClick
{
    // 代理方法
    if ([self.myDelegate respondsToSelector:@selector(tabBarClickSendCompose:)]) {
        [self.myDelegate tabBarClickSendCompose:self];
    }
}

//- (void)customLyaout
//{
//    int count = (int)self.buttons.count;
//    
//    
//    CGFloat btnW = self.bounds.size.width / (count + 1);
//    CGFloat btnH = self.bounds.size.height;
//    CGFloat btnY = 0;
//    
//    int i = 0;
//    
//    for (JDTabBar *btn in  self.buttons) {
//        
//        if (i == 2) {
//            i++;
//        }
//        CGFloat btnX = i * btnW;
//        
//        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
//        
//        i ++;
//    }
//    
//    self.plusButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
//}

@end
