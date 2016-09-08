//
//  JDEmotionKeyBoard.m
//  丁丁说
//
//  Created by JiangDing on 15/12/3.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDEmotionKeyBoard.h"
#import "JDEmotionScrollView.h"
#import "JDEmotionToolBar.h"
#import "JDEmotionTool.h"

@interface JDEmotionKeyBoard() <JDEmotionToolBarDelegate>

/** 自定义scrollView */
@property (nonatomic, weak) JDEmotionScrollView *scrollView;

/** 自定义toolbarView */
@property (nonatomic, weak) JDEmotionToolBar *toolBar;

@end

@implementation JDEmotionKeyBoard
 
+ (instancetype)keybaord
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];
        
        // 1. 添加scrollView
        JDEmotionScrollView *scrollView = [[JDEmotionScrollView alloc] init];
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2. 添加toolBarView
        JDEmotionToolBar *toolBar = [[JDEmotionToolBar alloc] init];
        toolBar.delegate = self;
        [self addSubview:toolBar];
        self.toolBar = toolBar;
    }
    return self;
}


// 布局子控件
- (void)layoutSubviews
{
    // 1. 布局toolBar
    self.toolBar.width = self.width;
    self.toolBar.height = 40;
    self.toolBar.x = 0;
    self.toolBar.y = self.height - self.toolBar.height;
    
    // 2. 布局scrollView
    self.scrollView.x = 0;
    self.scrollView.y = 0;
    self.scrollView.width = self.width;
    self.scrollView.height = self.toolBar.y;
}

#pragma mark - JDEmotionToolBarDelegate

- (void)emotionToolBar:(JDEmotionToolBar *)toolBar DidSelectedButton:(JDEmotionType)emotionType
{
    switch (emotionType) {
        case JDEmotionTypeDefault:
            // 赋值
            self.scrollView.emotions  = [JDEmotionTool defaultEmotions];
            break;
        case JDEmotionTypeEmoji:
            // 赋值
            self.scrollView.emotions = [JDEmotionTool emojiEmotions];
            break;
        case JDEmotionTypeLxh:
            // 赋值
            self.scrollView.emotions = [JDEmotionTool lxhEmotions];
            break;
        default:
            // 最近(通过存到沙河中，然后再取出来)
            self.scrollView.emotions = [JDEmotionTool recentEmotions];
            break;
    }
}

@end
