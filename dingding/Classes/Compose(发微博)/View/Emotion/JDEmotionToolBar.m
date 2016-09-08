//
//  JDEmotionToolBar.m
//  丁丁说
//
//  Created by JiangDing on 15/12/3.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDEmotionToolBar.h"

@interface toolBtn : UIButton

@end
 
@implementation toolBtn

- (void)setHighlighted:(BOOL)highlighted{

}

@end

@interface JDEmotionToolBar()

@property (nonatomic, strong) UIButton *selectedBtn;
@end

@implementation JDEmotionToolBar

// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 添加按钮
        [self addButtonWithTitle:@"最近" tag:JDEmotionTypeRecent];
        [self addButtonWithTitle:@"默认" tag:JDEmotionTypeDefault];
        [self addButtonWithTitle:@"Emoji" tag:JDEmotionTypeEmoji];
        [self addButtonWithTitle:@"浪小花" tag:JDEmotionTypeLxh];
        
    }
    return self;
}

/**
 *  添加单个按钮
 */
-(void)addButtonWithTitle:(NSString *)title tag:(JDEmotionType)emotionType
{
    toolBtn *button = [[toolBtn alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0];
 
    // 最左边的按钮
    if (self.subviews.count == 1) {
        [button setBackgroundImage:[UIImage strectchImageWithNamed:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage strectchImageWithNamed:@"compose_emotion_table_left_selected"] forState:UIControlStateSelected];
    
    // 最右边的按钮
    }else if (self.subviews.count == 4){
        [button setBackgroundImage:[UIImage strectchImageWithNamed:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage strectchImageWithNamed:@"compose_emotion_table_right_selected"] forState:UIControlStateSelected];
    }else{
        [button setBackgroundImage:[UIImage strectchImageWithNamed:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage strectchImageWithNamed:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    }
    // 添加方法
    [button addTarget:self action:@selector(toolBarClick:) forControlEvents:UIControlEventTouchDown];
    
    button.tag = emotionType;
    // 默认选中
    if (button.tag == 1) {
        [self toolBarClick:button];
    }
    
    [self addSubview:button];
}

/**
 *  方法
 */
- (void)toolBarClick:(toolBtn *)btn
{
    // 1. 取消上一个
    self.selectedBtn.selected = NO;

    // 2.
    btn.selected = YES;
    // 3. 赋值
    self.selectedBtn = btn;
    
    // 4. 代理
    if ([self.delegate respondsToSelector:@selector(emotionToolBar:DidSelectedButton:)]) {
        [self.delegate emotionToolBar:self DidSelectedButton:(int)btn.tag];
    }
}


- (void)setDelegate:(id<JDEmotionToolBarDelegate>)delegate
{
    _delegate = delegate;
    
    // 默认点击
    [self toolBarClick:self.subviews[1]];
}

/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = (int)self.subviews.count;
    
    CGFloat width = self.width / count;

    int i = 0;
    for (UIButton *btn in  self.subviews) {
        btn.width = width;
        btn.height = self.height;
        btn.y = 0;
        btn.x = width * i;
        
        i++;
    }
}

@end
