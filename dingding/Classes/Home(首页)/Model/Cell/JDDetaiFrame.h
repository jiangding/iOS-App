//
//  JDDetaiFrame.h
//  丁丁说
//
//  Created by JiangDing on 15/11/29.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JDStatus, JDMeFrame, JDOtherFrame;

@interface JDDetaiFrame : NSObject

/** 我的frame */
@property (nonatomic, strong) JDMeFrame * meFrame;

/** 转发的frame */
@property (nonatomic, strong) JDOtherFrame *otherFrame;

/** 自身的frame */
@property (nonatomic, assign) CGRect rect;

/** 模型数据 */
@property (nonatomic, strong) JDStatus *status;

@end
