//
//  JDEmotionPopView.h
//  丁丁说
//
//  Created by JiangDing on 15/12/4.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDEmotionBtn;

@interface JDEmotionPopView : UIView

/**
 *  初始化方法
 */
+ (instancetype)popView;

/**
 *  显示按钮
 */
- (void)showEmotionButton:(JDEmotionBtn *)emotionBtn;

/**
 *  去除方法
 */
- (void)dismiss;

@end
