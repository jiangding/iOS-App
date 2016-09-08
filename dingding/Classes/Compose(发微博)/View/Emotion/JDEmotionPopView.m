//
//  JDEmotionPopView.m
//  丁丁说
//
//  Created by JiangDing on 15/12/4.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDEmotionPopView.h"
#import "JDEmotionBtn.h"

@interface JDEmotionPopView()

// 单个按钮
@property (weak, nonatomic) IBOutlet JDEmotionBtn *emotionBtn;

@end
@implementation JDEmotionPopView

+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"JDEmotionPopView" owner:self options:nil] lastObject];
}


- (void)showEmotionButton:(JDEmotionBtn *)emotionBtn
{
    if (emotionBtn == nil) return;
 
    // 1. 设置图标
    self.emotionBtn.emotion = emotionBtn.emotion;
    
    // 包含到emotionView中的父控件中
    //[fromEmotionView.superview addSubview:self];
 
    // 2.添加到最顶层窗口上, 包括在键盘上面
     UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
 
    // 3. 位置
    // 添加到最顶层窗口上
    CGFloat centerX = emotionBtn.center.x;
    CGFloat centerY = emotionBtn.center.y - self.height * 0.5;
    CGPoint point = CGPointMake(centerX, centerY);
    // 把父控件的位置转换到window上面来
    self.center = [window convertPoint:point fromView:emotionBtn.superview];
    
}


- (void)dismiss
{
    [self removeFromSuperview];
}

@end
