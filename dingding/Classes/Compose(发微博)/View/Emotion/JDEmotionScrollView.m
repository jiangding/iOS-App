//
//  JDEmotionScrollView.m
//  丁丁说
//
//  Created by JiangDing on 15/12/3.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDEmotionScrollView.h"
#import "JDEmotionGridView.h"

@interface JDEmotionScrollView() <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scroll;

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation JDEmotionScrollView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 1. 添加ScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        // 隐藏两个子控件
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        // 分页
        scrollView.pagingEnabled = YES;
        // 设置代理
        scrollView.delegate = self;
        
        [self addSubview:scrollView];
        self.scroll = scrollView;
        
        // 2. 添加分页
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        
        // 利用KVC设置两个私有属性
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"_pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"_currentPageImage"];
        // 设置单页隐藏
        pageControl.hidesForSinglePage = YES;
        
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}


- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 1. 求总的页数(公式)
    self.pageControl.numberOfPages = (emotions.count + JDEmotionPerPageMaxCount - 1) / JDEmotionPerPageMaxCount;
    
    // 2. 当前scrollView的子控件
    NSArray *currentScorllSubViews = self.scroll.subviews;
    
    // 3. 再来在scrollView里面包含多个页, 每一页对应一个UIView
    for (int i = 0; i < self.pageControl.numberOfPages; i++) {
  
        JDEmotionGridView *perView = nil;
       // 如果大于就创建否则就用原来的!
        if (i >= currentScorllSubViews.count) {
            perView = [[JDEmotionGridView alloc] init];
            [self.scroll addSubview:perView];
        }else{
            perView = currentScorllSubViews[i];
        }
 
        // 求每页的emotion
        int loc = i * JDEmotionPerPageMaxCount;
        int len = JDEmotionPerPageMaxCount;
        // 解决溢出数组
        if (loc + len > emotions.count) {
            len = (int)(emotions.count - loc);
        }
        // 截取数组
        NSRange range = NSMakeRange(loc, len);
        // 每页emotion
        perView.emotions = [emotions subarrayWithRange:range];
        
        // 默认不隐藏
        perView.hidden = NO;
 
    }
    
    // 3.5 隐藏多余的gridView
    for (NSInteger j = self.pageControl.numberOfPages; j < currentScorllSubViews.count ; j++) {
        JDEmotionGridView *perView = currentScorllSubViews[j];
        perView.hidden = YES;
    }
    
    // 4. 重新布局
    [self setNeedsLayout];
    
    // 5. 表情滚动到最前面
    self.pageControl.currentPage = 0;
    self.scroll.contentOffset = CGPointZero;
 
}

// 重新布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1. 布局分页
    self.pageControl.x = 0;
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.y = self.height - self.pageControl.height;
    
    // 2. scroll
    self.scroll.x = 0;
    self.scroll.y = 0;
    self.scroll.width = self.width;
    self.scroll.height = self.pageControl.y;
    
    // 3. scroll中的子控件
    // 总页数
    int count = (int)self.pageControl.numberOfPages;
    
    CGFloat gridW = self.scroll.width;
    CGFloat gridH = self.scroll.height;
    // scroll的size
    self.scroll.contentSize = CGSizeMake(count * gridW, 0);
 
    for (int i = 0; i < count; i++) {
        JDEmotionGridView *v = self.scroll.subviews[i];
        v.x = i * gridW;
        v.width = gridW;
        v.height = gridH;
        v.y = 0;
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = (scrollView.contentOffset.x / scrollView.width + 0.5);
}

@end
