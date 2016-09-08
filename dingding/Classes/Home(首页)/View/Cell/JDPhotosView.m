//
//  JDPhotosView.m
//  丁丁说
//
//  Created by JiangDing on 15/11/30.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDPhotosView.h"
#import "JDPhoto.h"
#import "JDPhotoView.h"
#import "UIImageView+WebCache.h"

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"


#define JDPhotoViewMargin 5
// 设置宽度为屏幕最大值

#define JDPhotoViewW 76
#define JDPhotoViewH JDPhotoViewW

#define maxPhoto 9

#define JDStatusPhotosMaxCols(count) ((count == 4) ? 2 : 3)

@interface JDPhotosView()

// 记录上次的Frame
@property (nonatomic, assign)CGRect lastRect;
// imageV
@property (nonatomic, weak) UIImageView *imageV;

@end

@implementation JDPhotosView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
 
        // 考虑到循环利用cell的问题, 我们不能总是注销和创建UIImageView, 这样效率不好
        // 所以我们总是创建九个, 用来隐藏吧
        for (int i = 0; i < maxPhoto; i++) {
            JDPhotoView *photoView = [[JDPhotoView alloc] init];
            // 设置tag
            photoView.tag = i;
            [self addSubview:photoView];
            
            // 添加手势监听器
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
            [tapGesture addTarget:self action:@selector(tapPhoto:)];
            [photoView addGestureRecognizer:tapGesture];
        }
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    
    // 处理隐藏和显示
    for (int i = 0; i < maxPhoto; i++) {
        
        JDPhotoView *photoView = self.subviews[i];
        
        if (i >= photos.count) {
            photoView.hidden = YES; //隐藏
        }else{
            photoView.hidden = NO;// 显示图片
            
            JDPhoto *photo = photos[i];
            // 设置数据
            photoView.photoMod = photo;
        }
        
    }
    
}

+ (CGSize)sizeWithPhotoCount:(int)photoCount
{
 
    // 计算一行有多少列
    int maxCols = JDStatusPhotosMaxCols(photoCount);
    
    // 总列数
    int totalCols = photoCount >= maxCols ? maxCols : photoCount;
    
    // 总行数
    int totalRows = (photoCount + maxCols - 1) / maxCols;
    
    // 计算相册尺寸
    CGFloat photosW = totalCols * JDPhotoViewW + (totalCols - 1) * JDPhotoViewMargin;
    CGFloat photosH = totalRows * JDPhotoViewH + (totalRows - 1) * JDPhotoViewMargin;
    
    return CGSizeMake(photosW, photosH);
}


/**
  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
 
    int maxCols = JDStatusPhotosMaxCols(self.photos.count);
 
    for (int i = 0; i < self.photos.count; i ++) {
        JDPhotosView *photoView = self.subviews[i];
        photoView.width = JDPhotoViewW;
        photoView.height = JDPhotoViewH;
        photoView.x = (i % maxCols) * (JDPhotoViewW + JDPhotoViewMargin);
        photoView.y = (i / maxCols) * (JDPhotoViewH + JDPhotoViewMargin);
    }
 
}

    
#pragma mark - 手势监听器思路
- (void)tapPhoto:(UITapGestureRecognizer *)recognizer
{
    // 1.创建图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    // 2. 设置图片浏览器显示的所有图片
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < self.photos.count; i++) {
        
        // 创建图片对象
        MJPhoto *photo = [[MJPhoto alloc] init];
        
        
        JDPhoto *photoMod = self.photos[i];
        photo.url = [NSURL URLWithString:photoMod.bmiddle_pic];
        photo.srcImageView = self.subviews[i];
        
        // 添加
        [arr addObject:photo];
        
    }
    
    // 2. 设置所有图片
    browser.photos = arr;
    
    // 设置当前索引
    browser.currentPhotoIndex = recognizer.view.tag;
 
    // 显示
    [browser show];

}




//- (void)tapPhoto:(UIGestureRecognizer *)recognizer
//{
//    // 1. 添加一个遮盖按钮
//    UIView *cover = [[UIView alloc] init];
//    cover.frame = [UIScreen mainScreen].bounds;
//    cover.backgroundColor = [UIColor blackColor];
//    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCover:)]];
//    [[UIApplication sharedApplication].keyWindow addSubview:cover];
//    
//    
//    // 2. 将图片放到遮盖上面
//    JDPhotoView *photoV = (JDPhotoView *)recognizer.view;
//    UIImageView *imageV =  [[UIImageView alloc] init];
//    imageV.contentMode = UIViewContentModeScaleAspectFit;
//    [imageV sd_setImageWithURL:[NSURL URLWithString:photoV.photoMod.bmiddle_pic] placeholderImage:photoV.image];
//    // 将photoVew在self的坐标转为 在cover中的坐标
//    imageV.frame = [cover convertRect:photoV.frame fromView:self];
//    self.lastRect = imageV.frame;
//    [cover addSubview:imageV];
//    self.imageV = imageV;
//    
// 
//    // 3. 然后再动画扩大
//    [UIView animateWithDuration:0.25 animations:^{
//        imageV.x = 0;
//        imageV.width = cover.width;
//        imageV.height = cover.height / cover.width  * imageV.width;
//        imageV.y = (cover.height - imageV.height) * 0.5;
//    }];
//}

//- (void)tapCover:(UIGestureRecognizer *)recognizer
//{
//    [UIView animateWithDuration:0.25 animations:^{
//        recognizer.view.backgroundColor = [UIColor clearColor];
//        self.imageV.frame = self.lastRect;
//    } completion:^(BOOL finished) {
//        [recognizer.view removeFromSuperview];
//        self.imageV = nil;
//    }];
//}

@end
