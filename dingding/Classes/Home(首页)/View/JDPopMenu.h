//
//  JDPopMenu.h
//  丁丁说
//
//  Created by JiangDing on 15/11/21.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDPopMenu;

typedef enum {
    JDPopMenuIconArrowLeft = 1,
    JDPopMenuIconArrowRight,
    JDPopMenuIconArrowMid
} JDPopMenuIconType;

@protocol JDPopMenuDelegate <NSObject>

- (void)popMenuDidClickCover:(JDPopMenu *)popMenu;

@end

@interface JDPopMenu : UIView

/** 中间的view */
@property (nonatomic, strong) UIView *contentView;
/** 枚举,图标箭头方向 */
@property (nonatomic, assign) JDPopMenuIconType iconType;

/** 设置菜单的背景 */
@property (nonatomic, assign) BOOL isBackground;


@property (nonatomic, weak) id<JDPopMenuDelegate> delegate;

// 初始化方法
- (instancetype)initWithContentView:(UIView *)contentView;
+ (instancetype)popWithContentView:(UIView *)contentView;

// 位置
- (void)showInRect:(CGRect)rect;

/**
 *  点击cover消失popMenu
 */
- (void)dismiss;
 
@end
