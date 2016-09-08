//
//  JDCommonItem.m
//  丁丁说
//
//  Created by JiangDing on 15/12/7.
//  Copyright © 2015年 JiangDing. All rights reserved.
//  每一行显示的东西, 图片, 标题....

#import "JDCommonItem.h"

@implementation JDCommonItem

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    JDCommonItem *item = [[self alloc] init];
    item.title = title;
    if (icon != nil) {
        item.icon = [UIImage imageNamed:icon];
    }

    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title icon:nil];
}


@end
