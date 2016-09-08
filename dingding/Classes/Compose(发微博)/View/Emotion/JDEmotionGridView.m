//
//  JDEmotionGridView.m
//  丁丁说
//
//  Created by JiangDing on 15/12/3.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDEmotionGridView.h"
#import "JDEmotion.h"
#import "JDEmotionBtn.h"
#import "JDEmotionPopView.h"
#import "JDEmotionTool.h"

@interface JDEmotionGridView()

@property (nonatomic, weak) UIButton *deleteButton;
// 按钮数组
@property (nonatomic, strong) NSMutableArray *btns;

// 弹出popView
@property (nonatomic, strong) JDEmotionPopView *popView;
@end

@implementation JDEmotionGridView
// 懒加载
- (JDEmotionPopView *)popView
{
    if (_popView == nil) {
        _popView = [JDEmotionPopView popView];
    }
    return _popView;
}


// 懒加载
- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
        
        
        // 添加一个长按手势识别器
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] init];
        [longPressGesture addTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longPressGesture];
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 实际总数
    NSInteger count = emotions.count;
    // 1.获取当前每页emotionView总数, 一开始为0;
    NSInteger totalBtnCount = self.btns.count;
    for (int i = 0; i < count; i ++) {
        // 2.循环取btn
        JDEmotionBtn *btn = nil;
        // 如果(因为索引要小1, 所以要有=号, 等于0的时候也要创建
        if (i >= totalBtnCount) { // emotionView不够用
            btn = [[JDEmotionBtn alloc] init];
            
            // 添加点击
            [btn addTarget:self action:@selector(emotionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [self.btns addObject:btn];
            
        }else{ // 获取原来的
            btn = self.btns[i];
        }
        
        // 3. 设置单个按钮模型数据
        btn.emotion = emotions[i];
        
        // 4. 默认不隐藏
        btn.hidden = NO;
    }
    
    // 把多余的隐藏
    for (NSInteger i = count; i < totalBtnCount; i++) {
        JDEmotionBtn *btn = self.btns[i];
        btn.hidden = YES;
    }

}

/**
 *  长按事件
 */
- (void)longPress:(UILongPressGestureRecognizer *)longPressRecognizer
{
    // 1. 获取当前触摸点
    CGPoint point = [longPressRecognizer locationInView:longPressRecognizer.view];
    
    // 2. 计算当前触摸点在那个按钮上
    __block JDEmotionBtn *findBtn = nil;
    [self.btns enumerateObjectsUsingBlock:^(JDEmotionBtn *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        // 如果点在那个按钮范围内,就返回那个按钮, 并且要出来
        if (CGRectContainsPoint(btn.frame, point) && btn.hidden == NO) {
            // 返回当前的按钮
            findBtn = btn;
            // 停止遍历
            *stop = YES;
        }
        
    }];
    
    // 3. 手松开
    if (longPressRecognizer.state == UIGestureRecognizerStateEnded) {
        
        // 隐藏
        [self.popView dismiss];
        
        // 发送通知
        [self longPressSelectedEmotion:findBtn.emotion];
        
    }else{
        // 显示
        [self.popView showEmotionButton:findBtn];
    }
}
/**
 *  长按事件发送通知
 */
- (void)longPressSelectedEmotion:(JDEmotion *)foundEmotion
{
    // 如果没有被选中的emotion就返回
    if (foundEmotion == nil) return;
    
#warning 先必须保存好再发送通知
    [JDEmotionTool addEmotionRecent:foundEmotion];
    
    // 发送包含emotion信息的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:JDLongPressDidSelectedNotification object:nil userInfo:@{JDLongPressSelectedEmotion:foundEmotion}];
}

/**
 *  点击删除事件
 */
- (void)deleteClick
{
    // 发送删除emotion通知
    [[NSNotificationCenter defaultCenter] postNotificationName:JDLongPressDidDeleteNotification object:nil userInfo:nil];
}


/**
 *  单击事件
 */
- (void)emotionBtnClick:(JDEmotionBtn *)emotionBtn
{
    [self.popView showEmotionButton:emotionBtn];
    // 快速去除
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView dismiss];
    });
    
    // 发通知
    [self longPressSelectedEmotion:emotionBtn.emotion];
}

// 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 计算
    CGFloat margin = 10;
    
    CGFloat btnW = (self.width - 2 * margin) / JDEmotionPerColsCount;
    CGFloat btnH = (self.height - margin) / JDEmotionPerRowsCount;
    
    for (int i = 0; i < self.btns.count; i++) {
        
        UIButton *btn = self.btns[i];
        btn.x = margin + btnW * (i % JDEmotionPerColsCount);
        btn.y = margin + btnH * (i / JDEmotionPerColsCount);
        btn.width = btnW;
        btn.height = btnH;
        
    }
    
    // 固定X图标
    self.deleteButton.width = btnW;
    self.deleteButton.height = btnH;
    self.deleteButton.x = self.width - self.deleteButton.width - margin;
    self.deleteButton.y = self.height - self.deleteButton.height;
    
    
}

@end
