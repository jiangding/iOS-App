//
//  JDPhoto.m
//  丁丁说
//
//  Created by JiangDing on 15/11/24.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDPhoto.h"

@implementation JDPhoto

- (void)setThumbnail_pic:(NSString *)thumbnail_pic
{
    _thumbnail_pic = [thumbnail_pic copy];
    // 获取这个缩小图的时候赋值大图
    // 替换为高清的图片
    self.bmiddle_pic = [_thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}
@end
