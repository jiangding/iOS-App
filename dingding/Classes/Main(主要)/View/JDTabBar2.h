//
//  JDTabBar2.h
//  丁丁说
//
//  Created by JiangDing on 15/11/21.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDTabBar2;

@protocol JDTabBarDelegate <NSObject>

- (void)tabBar:(JDTabBar2 *)tabBar didChangeIndex:(NSInteger)index;

@end

@interface JDTabBar2 : UIView

// badge
@property (nonatomic,copy) NSString *badge;

@property (nonatomic, weak) id<JDTabBarDelegate> myDelegate;

@end
