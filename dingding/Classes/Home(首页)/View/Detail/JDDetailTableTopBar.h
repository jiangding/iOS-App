//
//  JDDetailTableTopBar.h
//  丁丁说
//
//  Created by JiangDing on 15/12/8.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDStatus,JDDetailTableTopBar;

// 按钮类型
typedef enum{
    JDTabTopBarTypeRetweeted,
    JDTabTopBarTypeComment,
    JDTabTopBarTypeZan
}JDTabTopBarType;

@protocol JDDetailTableTopBarDelegate <NSObject>

- (void)tableTopBar:(JDDetailTableTopBar *)tableTopBar DidSelectedBtn:(JDTabTopBarType)topBarType;
@end

@interface JDDetailTableTopBar : UIView

/** 当前选中的按钮类型 */
@property (nonatomic, assign) JDTabTopBarType selectedButtonType;

/** 模型数据 */
@property (nonatomic, strong) JDStatus *status;

/** 类型 */
@property (nonatomic) JDTabTopBarType type;

/** 代理 */
@property (nonatomic, weak) id<JDDetailTableTopBarDelegate> delegate;

/**
 *  初始化类方法
 */
+ (instancetype)toolBar;

@end
