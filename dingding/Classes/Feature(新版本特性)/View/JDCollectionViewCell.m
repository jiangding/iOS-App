//
//  JDCollectionViewCell.m
//  丁丁说
//
//  Created by JiangDing on 15/11/23.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDCollectionViewCell.h"
#import "JDTabBarController.h"

@interface JDCollectionViewCell()

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, weak) UIButton *shareBtn;

@property (nonatomic, weak) UIButton *startBtn;
@end

@implementation JDCollectionViewCell

// 懒加载
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
    }
    return _imageView;
}

- (UIButton *)shareBtn
{
    if (_shareBtn == nil) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"分享微博" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [btn sizeToFit];
        btn.adjustsImageWhenHighlighted = NO;
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [btn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.imageView addSubview:btn];
        
        self.shareBtn = btn;
    }
    return  _shareBtn;
}

- (UIButton *)startBtn
{
    if (_startBtn == nil) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"开始微博" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        
        [btn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
        [self.imageView addSubview:btn];
        
        self.startBtn = btn;
    }
    return  _startBtn;
}

// 设置图片
- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
    
}

// 设置最后一张
- (void)setLastImage:(BOOL)lastImage
{
    _lastImage = lastImage;
    
    if (lastImage) {
        self.shareBtn.hidden = NO;
        self.startBtn.hidden = NO;
    }else{
        self.shareBtn.hidden = YES;
        self.startBtn.hidden = YES;
    }
}


// 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
    self.shareBtn.center = CGPointMake(self.contentView.width * 0.5, self.contentView.height * 0.72);
    
    self.startBtn.center = CGPointMake(self.contentView.width * 0.5, self.contentView.height * 0.8);
}

/* 分享 */
- (void)shareClick:(UIButton *)btn
{
    btn.selected = !btn.isSelected;
}
/* 开始 */
- (void)startClick
{
    JDTabBarController *tabc = [[JDTabBarController alloc] init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = tabc;
}


@end
