//
//  JDSearchBar.m
//  丁丁说
//
//  Created by JiangDing on 15/11/21.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDSearchBar.h"

@implementation JDSearchBar

+ (JDSearchBar *)searchBar
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 设置背景图片
        self.background = [UIImage strectchImageWithNamed:@"searchbar_textfield_background"];
//        self.backgroundColor = JDColor(250, 250, 250);
//        self.layer.cornerRadius = 5;
        
        // 设置字体
        self.font = [UIFont systemFontOfSize:14.0];
        // 设置垂直居中
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

        // 设置左边图标
        UIImage *image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        UIImageView *imageView =  [[UIImageView alloc] init];
        imageView.image = image;
        imageView.width = imageView.image.size.width + 10;
        imageView.height = imageView.image.size.height;
        imageView.contentMode = UIViewContentModeCenter;
        
        self.leftView = imageView;
        // 一定要设置模式
        self.leftViewMode = UITextFieldViewModeAlways;
        
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
    }
    return self;
}
 

@end
