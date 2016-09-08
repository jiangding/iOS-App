//
//  JDOtherFrame.h
//  丁丁说
//
//  Created by JiangDing on 15/11/29.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JDStatus;

@interface JDOtherFrame : NSObject

/** 标题frame */
//@property (nonatomic, assign) CGRect titleFrame;

/** 正文frame */
@property (nonatomic, assign) CGRect textFrame;

/** 图片的frame */
@property (nonatomic, assign) CGRect photoFrame;


/** 自身的rect */
@property (nonatomic, assign) CGRect rect;

/** 模型数据 */
@property (nonatomic, strong) JDStatus *retweetedStatus;

@end
