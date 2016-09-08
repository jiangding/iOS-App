//
//  JDPopMenu.m
//  丁丁说
//
//  Created by JiangDing on 15/11/21.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDPopMenu.h"

@interface JDPopMenu()

@property (nonatomic, weak) UIButton *cover;

@property (nonatomic, weak) UIImageView *container;
@end

@implementation JDPopMenu

/* 初始化弹出框 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1. 添加cover
        UIButton *cover = [[UIButton alloc] init];
        cover.backgroundColor = [UIColor clearColor];
        [cover addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cover];
        self.cover = cover;
        
        // 2. 添加view
        UIImageView *container = [[UIImageView alloc] init];
        container.image = [UIImage strectchImageWithNamed:@"popover_background"];
        container.userInteractionEnabled = YES;
        [self addSubview:container];
        self.container = container;
        
    }
    return self;
}

- (instancetype)initWithContentView:(UIView *)contentView
{
    self = [super init];
    if (self) {
        self.contentView = contentView;
    }
    return self;
}
// 类方法初始化
+ (instancetype)popWithContentView:(UIView *)contentView
{
    return [[self alloc] initWithContentView:contentView];
}

// 设置iconType
- (void)setIconType:(JDPopMenuIconType)iconType
{
    _iconType = iconType;

    if (self.iconType == JDPopMenuIconArrowLeft) {
        self.container.image = [UIImage strectchImageWithNamed:@"popover_background_left"];
    }else if (self.iconType == JDPopMenuIconArrowRight){
        self.container.image = [UIImage strectchImageWithNamed:@"popover_background_right"];
    }
}

/**
 *  设置菜单的背景色
 */
- (void)setIsBackground:(BOOL)isBackground
{
    _isBackground = isBackground;
    
    if (isBackground) { // 如果YES
        self.cover.backgroundColor = [UIColor blackColor];
        self.cover.alpha = 0.2;
    }else{
        self.cover.backgroundColor = [UIColor clearColor];
        self.cover.alpha = 1.0;
    }
}

- (void)showInRect:(CGRect)rect
{
    // 1. 添加popMenu到最顶层
    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
    
    // 2. 设置view尺寸,并且添加
    self.container.frame = rect;
    [self.container addSubview:self.contentView];
    
    // 3. 设置容器里面内容的frame
    CGFloat topMargin = 12;
    CGFloat leftMargin = 5;
    CGFloat bottomMargin = 8;
    self.contentView.x = leftMargin;
    self.contentView.y = topMargin;
    self.contentView.width = rect.size.width - leftMargin * 2;
    self.contentView.height = rect.size.height - topMargin - bottomMargin;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 布局子控件,设置子控件
    self.cover.frame = self.bounds;
}

/**
 *  点击cover消失popMenu
 */
- (void)dismiss
{
    if ([self.delegate respondsToSelector:@selector(popMenuDidClickCover:)]) {
        [self.delegate popMenuDidClickCover:self];
    }
    // 不在删除
    //[self removeFromSuperview];
    // 直接隐藏
    self.alpha = 0.0;
}

@end
