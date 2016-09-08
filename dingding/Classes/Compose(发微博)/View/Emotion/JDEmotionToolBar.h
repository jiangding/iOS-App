//
//  JDEmotionToolBar.h
//  丁丁说
//
//  Created by JiangDing on 15/12/3.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDEmotionToolBar;

typedef enum {
    JDEmotionTypeRecent, // 最近
    JDEmotionTypeDefault, // 默认
    JDEmotionTypeEmoji, // Emoji
    JDEmotionTypeLxh // 浪小花
} JDEmotionType;

@protocol JDEmotionToolBarDelegate<NSObject>

- (void)emotionToolBar:(JDEmotionToolBar *)toolBar DidSelectedButton:(JDEmotionType)emotionType;

@end

@interface JDEmotionToolBar : UIView

// 代理
@property (nonatomic, weak)id<JDEmotionToolBarDelegate> delegate;

@end
