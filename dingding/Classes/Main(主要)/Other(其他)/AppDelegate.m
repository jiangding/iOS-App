//
//  AppDelegate.m
//  丁丁说
//
//  Created by JiangDing on 15/11/20.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "AppDelegate.h"
#import "JDTabBarController.h"
#import "JDFeatureController.h"
#import "JDFeatureCellController.h"
#import "JDOAuthController.h"

#import "JDAccountTool.h"
#import "JDControlTool.h"
#import "JDAccount.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "UIImageView+WebCache.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
 
    // 1. 创建UIWindow
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
  
    // 2. 设置window的主控制器
    
    // 查看是否已经登陆
    JDAccount *account = [JDAccountTool account];
    if (account){
        // 切换不同的控制器
        self.window.rootViewController = [JDControlTool chooseRootViewController];
    }else{
        self.window.rootViewController = [[JDOAuthController alloc] init];
    }
 
    // 3. 显示并且称为主窗口
    [self.window makeKeyAndVisible];
    
     //4.监控网络
        AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
        // 当网络状态改变了，就会调用
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown: // 未知网络
                case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                    [MBProgressHUD showError:@"网络异常，请检查网络设置！"];
                    break;
    
                case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                    JDLog(@"手机自带网络");
                    break;
    
                case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                    JDLog(@"WIFI");
                    break;
            }
        }];
        // 开始监控
        [mgr startMonitoring];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    JDLog(@"内存警告");
    // 赶紧清除所有的内存缓存
    [[SDImageCache sharedImageCache] clearMemory];
    
    // 赶紧停止正在进行的图片下载操作
    [[SDWebImageManager sharedManager] cancelAll];
}

@end
