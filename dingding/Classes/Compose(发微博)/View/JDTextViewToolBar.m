//
//  JDTextViewToolBar.m
//  丁丁说
//
//  Created by JiangDing on 15/11/25.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDTextViewToolBar.h"
@interface JDTextViewToolBar()

/** emotion按钮 */
@property (nonatomic, weak) UIButton  *emotionBtn;

@end

@implementation JDTextViewToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background_os7"]];
        
        // 添加按钮
        [self addOneButtonWithIcon:@"compose_camerabutton_background_os7"  hightIcon:@"compose_camerabutton_background_highlighted_os7" tag:JDTextViewToolBarTypeCamera];
        [self addOneButtonWithIcon:@"compose_toolbar_picture_os7" hightIcon:@"compose_toolbar_picture_highlighted_os7" tag:JDTextViewToolBarTypePicture];
        [self addOneButtonWithIcon:@"compose_mentionbutton_background_os7"  hightIcon:@"compose_mentionbutton_background_highlighted_os7" tag:JDTextViewToolBarTypeMention];
        [self addOneButtonWithIcon:@"compose_trendbutton_background_os7" hightIcon:@"compose_trendbutton_background_highlighted_os7" tag:JDTextViewToolBarTypeTrend];
        self.emotionBtn = [self addOneButtonWithIcon:@"compose_emoticonbutton_background_os7" hightIcon:@"compose_emoticonbutton_background_highlighted_os7" tag:JDTextViewToolBarTypeEmotion];
        
    }
    return self;
}


/**
 *  添加单个按钮
 */
- (UIButton *)addOneButtonWithIcon:(NSString *)icon hightIcon:(NSString *)hightIcon tag:(JDTextViewToolBarType)tag
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hightIcon] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [self addSubview:btn];
    
    return btn;
}

/**
 *  点击方法
 */
- (void)buttonClick:(UIButton *)btn
{
    // 代理
    if ([self.delegate respondsToSelector:@selector(jdTextViewToolBar:DidClickButton:)]) {
        [self.delegate jdTextViewToolBar:self DidClickButton:(JDTextViewToolBarType)btn.tag];
    }
}

/**
 *  切换键盘重新设置emotion图标
 */
- (void)setShowEmotion:(BOOL)showEmotion
{
    _showEmotion = showEmotion;
    
    // 如果是YES
    if (showEmotion) { // 显示emotion
        [self.emotionBtn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_os7"] forState:UIControlStateNormal];
        [self.emotionBtn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted_os7"] forState:UIControlStateHighlighted];
    }else{ // 显示键盘按钮
        [self.emotionBtn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionBtn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = (int)self.subviews.count;
    
    CGFloat width = self.width / count;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        
        btn.x = i * width;
        btn.y = 0;
        btn.width = width;
        btn.height = self.height;
    }
}


@end
