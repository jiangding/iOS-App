//
//  JDTabBar.h
//  丁丁说
//
//  Created by JiangDing on 15/11/21.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDTabBar;

@protocol JDTabBarDelegate <NSObject>

//- (void)tabBar:(JDTabBar *)tabBar didChangeIndex:(NSInteger)index;
- (void)tabBarClickSendCompose:(JDTabBar *)tabBar;

@end

@interface JDTabBar : UITabBar

/** 对应tabBarItem模型 */
//@property (nonatomic, strong) NSMutableArray *tabBarItems;
// 代理
@property (nonatomic, weak) id<JDTabBarDelegate> myDelegate;

@end
