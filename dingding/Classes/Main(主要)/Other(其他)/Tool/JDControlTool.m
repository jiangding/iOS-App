//
//  JDControlTool.m
//  丁丁说
//
//  Created by JiangDing on 15/11/23.
//  Copyright © 2015年 JiangDing. All rights reserved.
//  控制器处理类

#import "JDControlTool.h"
#import "JDTabBarController.h"
#import "JDFeatureCellController.h"


@implementation JDControlTool

+ (UIViewController *)chooseRootViewController
{
    // 1. 取出公用的key
    NSString *versionKey =(__bridge NSString *) kCFBundleVersionKey;
    
    // 2. 取出当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    // 3. 取出沙盒存的最新的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionKey];
 
    // 判断
    if ([currentVersion isEqualToString:lastVersion]) {
        return [[JDTabBarController alloc] init];
    }else{
        // 更新沙盒版本
        [defaults setObject:currentVersion forKey:versionKey];
        [defaults synchronize];
        
        return [[JDFeatureCellController alloc] init];
    }
}

@end
