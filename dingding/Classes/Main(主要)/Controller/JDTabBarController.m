//
//  JDTabBarController.m
//  丁丁说
//
//  Created by JiangDing on 15/11/20.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDTabBarController.h"
#import "JDNavigationController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "JDHomeController.h"
#import "JDMessageController.h"
#import "JDDiscoverController.h"
#import "JDProfileController.h"

#import "JDComposeController.h"

#import "JDTabBar.h"

#import "JDUserTool.h"
#import "JDUnReadCountResult.h"
#import "JDUnReadCountParam.h"
#import "JDAccountTool.h"
#import "JDAccount.h"

@interface JDTabBarController () <JDTabBarDelegate>
@property (nonatomic, weak)JDHomeController *home;
@property (nonatomic, weak)JDMessageController *message;
@property (nonatomic, weak)JDProfileController *profile;

@property (nonatomic, strong) UIViewController *lastSelectedViewContoller;
@property (nonatomic, strong) NSMutableArray *items;
/** 系统声音id */
@property (nonatomic, assign) SystemSoundID soundID;
@end

@implementation JDTabBarController

/**
 *  懒加载
 */
- (NSMutableArray *)items
{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    // 0.获取水滴声音系统url
//    NSURL * url = [[NSBundle mainBundle] URLForResource:@"water.caf" withExtension:nil];
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &(_soundID));
 
    // 1. 添加子控制器
    [self addAllChildController];
 
    // 2. 添加自定义tabBar
    JDTabBar *tabBar = [[JDTabBar alloc] init];
    //tabBar.frame = self.tabBar.frame;
    //[self.view addSubview:tabBar];
 
    // 3. 设置代理
    tabBar.myDelegate = self;
    
    // 4. 赋值
    //tabBar.tabBarItems = self.items;
    
    // 替换掉系统的tabar
    [self setValue:tabBar forKeyPath:@"tabBar"];

    // 5. 删除系统自带的tabBar
    //[self.tabBar removeFromSuperview];
    
    
    
    // 6. 添加计算当前未读数目
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:8.0 target:self selector:@selector(getCurrentUnRead) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/**
 *  未读数目
 */
- (void)getCurrentUnRead
{
    // 1. 参数
    JDUnReadCountParam *params = [[JDUnReadCountParam alloc] init];
    params.access_token = [JDAccountTool account].access_token;
    params.uid = [JDAccountTool account].uid;
    
    [JDUserTool getUnReadCountWithParam:params success:^(JDUnReadCountResult *result) {
        // 显示微博未读数
        if (result.status == 0) {
            self.home.tabBarItem.badgeValue = nil;
        } else if(result.status < 100){
            self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        }else{
            self.home.tabBarItem.badgeValue = @"N";
        }
        
        // 显示消息未读数
        if (result.messageCount == 0) {
            self.message.tabBarItem.badgeValue = nil;
        } else {
            self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        }
        
        // 显示新粉丝数
        if (result.follower == 0) {
            self.profile.tabBarItem.badgeValue = nil;
        } else {
            self.profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        }

        
    } failure:^(NSError *error) {
        JDLog(@"未读数目:%@", error);
    }];
}

/**
 *  添加tabBar控制器
 */
- (void)addAllChildController
{
    // 首页
    JDHomeController *home = [[JDHomeController alloc] init];
    self.home = home;
    [self addOneTabBarItemWithController:home icon:@"tabbar_home_os7" selectedIcon:@"tabbar_home_selected_os7" title:@"首页"];

    // 消息
    JDMessageController *message = [[JDMessageController alloc] init];
    self.message = message;
    [self addOneTabBarItemWithController:message icon:@"tabbar_message_center_os7" selectedIcon:@"tabbar_message_center_selected_os7" title:@"消息"];
 
    // 发现
    JDDiscoverController *discover = [[JDDiscoverController alloc] init];
    [self addOneTabBarItemWithController:discover icon:@"tabbar_discover_os7" selectedIcon:@"tabbar_discover_selected_os7" title:@"发现"];

    // 我的
    JDProfileController *profile = [[JDProfileController alloc] init];
    self.profile = profile;
    [self addOneTabBarItemWithController:profile icon:@"tabbar_profile_os7" selectedIcon:@"tabbar_profile_selected_os7" title:@"我的"];
}

/**
 *  添加单个tabBarItem
 *
 *  @param icon         icon description
 *  @param selectedIcon selectedIcon description
 *  @param title        title description
 */
- (void)addOneTabBarItemWithController:(UIViewController *)vc icon:(NSString *)icon selectedIcon:(NSString *)selectedIcon title:(NSString *)title
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:icon];
    //vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedIcon];
    
    // 设置tabBarItem文字
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [vc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [vc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    
    UIImage *selected = [UIImage imageNamed:selectedIcon];
    vc.tabBarItem.selectedImage = [selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //vc.tabBarItem.badgeValue = @"10";
    
    // 添加到数组中
    //[self.items addObject:vc.tabBarItem];
    
    JDNavigationController *nav = [[JDNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}

#pragma mark - JDTabBarDelegate

- (void)tabBar:(JDTabBar *)tabBar didChangeIndex:(NSInteger)index
{
    int idx = (int)index;
    
    // 切换控制器
    self.selectedViewController = self.childViewControllers[idx];
}

- (void)tabBarClickSendCompose:(JDTabBar *)tabBar
{
    // 播放系统声音
    AudioServicesPlaySystemSound(1210);
    //AudioServicesPlaySystemSound(_soundID);
    
    JDComposeController *compose = [[JDComposeController alloc] init];
    compose.prefix = @"发微博";
    compose.holder = @"分享新鲜事...";
    JDNavigationController *nav = [[JDNavigationController alloc] initWithRootViewController:compose];
    
    [self presentViewController:nav animated:YES completion:nil];
}

@end
