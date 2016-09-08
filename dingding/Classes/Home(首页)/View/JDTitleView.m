//
//  JDTitleView.m
//  丁丁说
//
//  Created by JiangDing on 15/12/13.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDTitleView.h"

@interface JDTitleView()
 
@property (nonatomic ,strong) UIButton *selectedBtn;

@end

@implementation JDTitleView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        // 设置
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        [self addButtons];
    }
    return self;
}


- (void)addButtons
{
    
    [self addButtonWithImage:nil title:@"首页" tag:JDHomeTitleTypeDefault];
    [self addButtonWithImage:nil title:@"好友圈" tag:JDHomeTitleType1];
    [self addButtonWithImage:nil title:@"我的微博" tag:JDHomeTitleType2];
    [self addButtonWithImage:nil title:@"名人" tag:JDHomeTitleType3];
    [self addButtonWithImage:nil title:@"电影" tag:JDHomeTitleType4];
    [self addButtonWithImage:nil title:@"科技" tag:JDHomeTitleType5];
}


/**
 *  添加按钮方法
 */
- (void)addButtonWithImage:(NSString *)icon title:(NSString *)title tag:(JDHomeTitleType)tag
{
    UIButton *btn = [[UIButton alloc] init];
    //[btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor grayColor]] forState:UIControlStateDisabled];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateDisabled];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    btn.adjustsImageWhenHighlighted = NO;
   
    
    // 设置位置左边
    //btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);

 
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
 
    btn.tag = tag;
    
    // 默认第一个disabeld
    if (tag == JDHomeTitleTypeDefault) {
        [self btnClick:btn];
        
    }
 
    [self addSubview:btn];
 
 
}

/**
 *  点击button
 */
- (void)btnClick:(UIButton *)btn
{
    // 1.
    self.selectedBtn.enabled = YES;
    
    // 2.
    btn.enabled = NO;
 
    // 4. 发送通知, 传递数组过去
    NSDictionary *dict = @{@"tag" : [NSNumber numberWithInt:(int)btn.tag], @"text" : btn.titleLabel.text};
    [[NSNotificationCenter defaultCenter] postNotificationName:JDHomeStatusTitleNotifcation object:self userInfo:@{ JDHomeStatusTitleInfo : dict }];
 
    // 3. 赋值
    self.selectedBtn = btn;
 
}

- (void)layoutSubviews
{
    int count = (int)self.subviews.count;
 
    CGFloat height = 44;
    CGFloat width = self.width;
    
    // 设置scrollView的contentSize
    self.contentSize = CGSizeMake(self.width, count * height);
    
    int i = 0;
    for (UIButton *btn in self.subviews) {
        btn.x = 0;
        btn.width = width;
        btn.height = height;
        btn.y = i * height;
        i ++;
    }
}
 
@end
