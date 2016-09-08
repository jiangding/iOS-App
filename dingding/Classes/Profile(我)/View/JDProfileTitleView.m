//
//  JDProfileTitleView.m
//  丁丁说
//
//  Created by JiangDing on 15/12/11.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDProfileTitleView.h"
#import "JDPrifileButtonView.h"
#import "JDProfileInfoView.h"

@interface JDProfileTitleView()

/** 个人信息view */
@property (nonatomic, weak) JDProfileInfoView *infoView;
/** 底部微博 关注 粉丝 */
@property (nonatomic, weak) JDPrifileButtonView *btnView;

@end

@implementation JDProfileTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = JDGlobColor;
        
        // 添加两个子视图
        // 1. 上部
        JDProfileInfoView *infoView = [[JDProfileInfoView alloc] init];
        [self addSubview:infoView];
        self.infoView = infoView;
        
        // 2. 下部
        JDPrifileButtonView *buttonView = [[JDPrifileButtonView alloc] init];
        [self addSubview:buttonView];
        self.btnView = buttonView;
    }
    return self;
}

/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1. 设置infoView
    self.infoView.x = 0;
    self.infoView.width = self.width;
    self.infoView.height = 86;
 
    // 2. 设置buttonView
    self.btnView.width = self.width;
    self.btnView.height = 50;
    self.btnView.y = self.infoView.height - 1;
 
}
@end
