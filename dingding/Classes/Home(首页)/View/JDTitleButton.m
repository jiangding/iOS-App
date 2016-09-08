//
//  JDTitleButton.m
//  丁丁说
//
//  Created by JiangDing on 15/11/21.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDTitleButton.h"

#define JDTitleFont [UIFont boldSystemFontOfSize:18.0]


@implementation JDTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
 
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
        // 设置背景
        [self setBackgroundImage:[UIImage strectchImageWithNamed:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        
        self.titleLabel.font = JDTitleFont;
        self.height = 35;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        // 设置图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 取消点击效果
        self.adjustsImageWhenHighlighted = NO;
        
        // 设置文字靠右边
        self.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return self;
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    // 默认图片长宽都等于高度
    CGFloat imageW = self.height;
    CGFloat imageX = self.width - imageW;
    CGFloat imageY = 0;
    CGFloat imageH = self.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = self.width - self.height;
    CGFloat titleH = self.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

// 计算文字的尺寸
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{

    [super setTitle:title forState:state];
    
    // 1. 计算文字的尺寸
    CGSize textSize = [title sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    
    // 2. 设置宽度
    self.width = textSize.width + self.height + 10;
}





@end
