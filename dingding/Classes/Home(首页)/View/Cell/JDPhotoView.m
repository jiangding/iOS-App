//
//  JDPhotoView.m
//  丁丁说
//
//  Created by JiangDing on 15/11/30.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDPhotoView.h"
#import "UIImageView+WebCache.h"
#import "JDPhoto.h"

@interface JDPhotoView()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation JDPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        
        // 设置图片显示类型
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        // 添加一个girView
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return self;
}



// 设置数据
- (void)setPhotoMod:(JDPhoto *)photoMod
{
    _photoMod = photoMod;
 
    // 如果后缀名是gif就显示这种图片
    NSString *extension =  photoMod.thumbnail_pic.pathExtension.lowercaseString;
    self.gifView.hidden = ![extension isEqualToString:@"gif"];
    
    // 如果是gif 就显示小图
    NSString *pic = ![extension isEqualToString:@"gif"] ? photoMod.bmiddle_pic : photoMod.thumbnail_pic;
    
    [self sd_setImageWithURL:[NSURL URLWithString:pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
 
}


// 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
