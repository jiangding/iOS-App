//
//  JDFeatureController.m
//  丁丁说
//
//  Created by JiangDing on 15/11/23.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDFeatureController.h"
#import "JDTabBarController.h"

#define JDImageCount 4

@interface JDFeatureController() <UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scroll;
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation JDFeatureController

// 隐藏顶部导航
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    // 1. 添加scroll
    [self addScroll];
    
    // 2. 添加pageControl
    [self addPage];

}

#pragma mark - UIScrollViewDelegate
// 拖动scroll的时候
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取当前的页码
    CGFloat count = scrollView.contentOffset.x / scrollView.width;
    int number = (int)(count + 0.5);
    
    self.pageControl.currentPage = number;
  
}

/**
 *  添加scroll
 */
- (void)addScroll
{
    // 1. 添加Scroll
    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.frame = self.view.bounds;
    
    // 设置scroll属性
    scroll.contentSize = CGSizeMake(scroll.width * JDImageCount, scroll.height);
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.bounces = NO;
    scroll.pagingEnabled = YES;
    
    // 设置代理方法
    scroll.delegate = self;
    
    for (int i = 0; i < JDImageCount; i ++) {
        
        // 获取图片信息
        NSString *iconStr = [NSString stringWithFormat:@"new_feature_%d", (i+1)];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconStr]];
        
        // 设置图片frame
        imageView.width = scroll.width;
        imageView.height = scroll.height;
        imageView.x = i * imageView.width;
        
        // 给最后一个imageView加开始微博按钮
        if (i == (JDImageCount - 1)) {
            [self addLastImageView:imageView];
        }
        // 添加
        [scroll addSubview:imageView];
    }
    
    [self.view addSubview:scroll];
    
    self.scroll = scroll;
}

/**
 *  添加最后一个图片的按钮
 */
- (void)addLastImageView:(UIImageView *)imageView
{
    
    // 设置imageView可用
    imageView.userInteractionEnabled = YES;
    
    // 1. 添加分享
    UIButton *share = [[UIButton alloc] init];
    share.adjustsImageWhenHighlighted = NO;
    [share setTitle:@"分享微博" forState:UIControlStateNormal];
    [share setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [share setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [share setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [share sizeToFit];
    share.center = CGPointMake(imageView.width * 0.5, imageView.height * 0.72);
    share.titleLabel.font = [UIFont systemFontOfSize:16.0];
    // 设置
    share.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    share.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);

    // 添加方法
    [share addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:share];
    
    
    // 2. 添加开始微博
    UIButton *begin = [[UIButton alloc] init];
    [begin setTitle:@"开始微博" forState:UIControlStateNormal];
    [begin setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [begin setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [begin sizeToFit];
    begin.center = CGPointMake(imageView.width * 0.5, imageView.height * 0.8);
    
    // 添加方法
    [begin addTarget:self action:@selector(startBegin) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:begin];
}

/**
 *  分享微博
 */
- (void)shareClick:(UIButton *)btn
{
    btn.selected = !btn.isSelected;
    JDLog(@"分享");
}

/**
 *  点击开始微博
 */
- (void)startBegin
{
    JDTabBarController *tabBar = [[JDTabBarController alloc] init];

    [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
}


/**
 *  添加page
 */
- (void)addPage
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = JDImageCount;
    pageControl.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.88);
    [self.view addSubview:pageControl];
    
    // 设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = JDColor(253, 98, 42); // 当前页的小圆点颜色
    pageControl.pageIndicatorTintColor = JDColor(189, 189, 189); // 非当前页的小圆点颜色
    
    self.pageControl = pageControl;
}

@end
