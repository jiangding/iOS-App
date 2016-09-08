//
//  JDControlTool.h
//  丁丁说
//
//  Created by JiangDing on 15/11/23.
//  Copyright © 2015年 JiangDing. All rights reserved.
//  控制器类

#import <Foundation/Foundation.h>

@interface JDControlTool : NSObject

/**
 *  版本更新切换不同的控制器
 */
+ (UIViewController *)chooseRootViewController;

@end
