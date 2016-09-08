//
//  JDTextViewPhotoView.m
//  丁丁说
//
//  Created by JiangDing on 15/11/25.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDTextViewPhotoView.h"
#import "MBProgressHUD+MJ.h"

#define JDPerRow 3

@interface JDTextViewPhotoView()

@end
@implementation JDTextViewPhotoView



// 设置图片
- (void)setImage:(UIImage *)image
{
    _image = image;
    
    // 判断是否超过最大限制
    if (self.subviews.count > 8) {
        [MBProgressHUD showError:@"超过了最大限制图片!"];
        return;
    }
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    // 多余的截取掉
    imageView.clipsToBounds = YES;
    imageView.image = image;
    [self addSubview:imageView];
}

// 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 获取总数
    int count = (int)self.subviews.count;
    
    // 图片间距离
    CGFloat margin = 10;
    
    // 每个图片宽高
    CGFloat width = (self.width - (JDPerRow + 1) * margin) / JDPerRow;
    CGFloat height = width;

    for (int i = 0; i < count; i++) {
        // 行号
        int row = i / JDPerRow;
        // 列号
        int col = i % JDPerRow;

        UIImageView *imageView = self.subviews[i];
        imageView.width = width;
        imageView.height = height;
        imageView.y = row * (width + margin);
        imageView.x = col * (height + margin) + margin;
    }
}

- (NSArray *)images
{
    NSMutableArray *array = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [array addObject:imageView.image];
    }
    return array;
}

@end
