//
//  UIImage+Extension.h
//  丁丁说
//
//  Created by JiangDing on 15/11/21.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)


// 拉伸一张图片
+ (UIImage *)strectchImageWithNamed:(NSString *)icon;

// 返回一张图片用颜色
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
