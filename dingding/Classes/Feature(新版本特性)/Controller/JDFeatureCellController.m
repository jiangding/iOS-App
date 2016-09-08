//
//  JDFeatureCellController.m
//  丁丁说
//
//  Created by JiangDing on 15/11/23.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDFeatureCellController.h"
#import "JDCollectionViewCell.h"

#define JDFeatureImageCount 4

@interface JDFeatureCellController()

@property (nonatomic, weak) UIPageControl *pageControl;

@end
@implementation JDFeatureCellController

static NSString * const Identifier = @"Cell";

// 设置隐藏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (instancetype)init
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置单个尺寸
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    
    // 设置方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置间距
    flowLayout.minimumLineSpacing = 0;
 
    return [super initWithCollectionViewLayout:flowLayout];
}

// 使用UICollectionViewController
// 1.初始化的时候设置布局参数
// 2.必须collectionView要注册cell
// 3.自定义cell
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 注册cell
    [self.collectionView registerClass:[JDCollectionViewCell class] forCellWithReuseIdentifier:Identifier];
    
    // 设置collectionView
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    
    // 2. 添加pageControl
    [self addPage];
    
}

/**
 *  添加page
 */
- (void)addPage
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = JDFeatureImageCount;
    pageControl.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.88);
    [self.view addSubview:pageControl];
    
    // 设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = JDColor(253, 98, 42); // 当前页的小圆点颜色
    pageControl.pageIndicatorTintColor = JDColor(189, 189, 189); // 非当前页的小圆点颜色
    
    self.pageControl = pageControl;
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

#pragma mark - UICollectionView数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return JDFeatureImageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.首先从缓存池里取cell
    JDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    // 获取图片名称
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld", indexPath.row + 1];
    // 设置图片
    cell.image = [UIImage imageNamed:imageName];
    
    // 当图片是最后一张时
    if ((indexPath.row + 1) == JDFeatureImageCount) {
        cell.lastImage = YES;
    }else{
        cell.lastImage = NO;
    }
    
    return cell;
}

@end
