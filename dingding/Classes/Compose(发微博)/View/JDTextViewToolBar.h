//
//  JDTextViewToolBar.h
//  丁丁说
//
//  Created by JiangDing on 15/11/25.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDTextViewToolBar;

typedef enum {
    JDTextViewToolBarTypeCamera, //照相机
    JDTextViewToolBarTypePicture, // 图片
    JDTextViewToolBarTypeMention, // @
    JDTextViewToolBarTypeTrend, // #
    JDTextViewToolBarTypeEmotion // emoji
} JDTextViewToolBarType;


@protocol JDTextViewToolBarDelegate <NSObject>

- (void)jdTextViewToolBar:(JDTextViewToolBar *)toolBar DidClickButton:(JDTextViewToolBarType)toolBarType;

@end

@interface JDTextViewToolBar : UIView

@property (nonatomic, weak) id<JDTextViewToolBarDelegate> delegate;

/** 当前键盘emotion显示图标 */
@property (nonatomic, assign, getter=isShowEmotion) BOOL showEmotion;

@end
