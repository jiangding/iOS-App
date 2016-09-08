//
//  UIBarButtonItem+Icon.h
//  丁丁说
//
//  Created by JiangDing on 15/11/21.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Icon)

/**
 *  添加一个UIBarbuttonItem 图片
 *
 *  @param icon      icon description
 *  @param hightIcon hightIcon description
 *  @param target    target description
 *  @param action    action description
 *
 *  @return return value description
 */
+ (UIBarButtonItem *)initWithIcon:(NSString *)icon hightIcon:(NSString *)hightIcon target:(id)target action:(SEL)action;

@end
