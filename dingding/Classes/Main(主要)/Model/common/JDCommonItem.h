//
//  JDCommonItem.h
//  丁丁说
//
//  Created by JiangDing on 15/12/7.
//  Copyright © 2015年 JiangDing. All rights reserved.
//  每一行显示的东西, 图片, 标题....

#import <Foundation/Foundation.h>

@interface JDCommonItem : NSObject
/** 图标 */
@property (nonatomic, strong) UIImage *icon;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 子标题 */
@property (nonatomic, copy) NSString *subTitle;
/** badgeValue */
@property (nonatomic, copy) NSString *badgeValue;

/** block, 记得用copy*/
@property (nonatomic, copy) void (^block)();

/** 跳转的目的控制器 */
@property (nonatomic, strong) Class destClass;
/**
 初始化类方法
 */
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
+ (instancetype)itemWithTitle:(NSString *)title;
@end
