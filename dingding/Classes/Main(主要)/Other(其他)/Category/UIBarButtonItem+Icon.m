//
//  UIBarButtonItem+Icon.m
//  丁丁说
//
//  Created by JiangDing on 15/11/21.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "UIBarButtonItem+Icon.h"

@implementation UIBarButtonItem (Icon)

+ (UIBarButtonItem *)initWithIcon:(NSString *)icon hightIcon:(NSString *)hightIcon target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hightIcon] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];

    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
