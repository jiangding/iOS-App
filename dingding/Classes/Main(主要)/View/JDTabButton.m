//
//  JDTabButton.m
//  丁丁说
//
//  Created by JiangDing on 15/11/21.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDTabButton.h"
#import "JDBadgeView.h"

#define TIconW 30

@interface JDTabButton()
@property (nonatomic, weak) JDBadgeView *badgeView;
@end

@implementation JDTabButton

- (void)setHighlighted:(BOOL)highlighted
{
}

// 懒加载
- (JDBadgeView *)badgeView
{
    if (_badgeView == nil) {
        JDBadgeView *badgeView = [[JDBadgeView alloc] init];
        // 添加badge
        [self addSubview:badgeView];
        self.badgeView = badgeView;
        
    }
    return _badgeView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:12.0];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    }
    return self;
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
 
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
 
    //KVO 时刻监听一个对象的属性有没有改变
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
   
}
// 只要有新的值就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    // 设置badge
    self.badgeView.badge = self.item.badgeValue;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置badgeView的frame
    self.badgeView.x = (self.width - TIconW) * 0.5 + TIconW - 10;
    self.badgeView.y = 0;
  
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = TIconW;
    CGFloat imageH = imageW;
    CGFloat imageX = (self.width - imageW) * 0.5;
    CGFloat imageY = 2;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = (self.width - TIconW) * 0.5;
    CGFloat titleY = TIconW;
    CGFloat titleW = TIconW;
    CGFloat titleH = 15;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
