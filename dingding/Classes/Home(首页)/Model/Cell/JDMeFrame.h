//
//  JDMeFrame.h
//  丁丁说
//
//  Created by JiangDing on 15/11/29.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JDStatus;

@interface JDMeFrame : NSObject

/** 头像frame */
@property (nonatomic, assign) CGRect iconFrame;

/** 标题frame */
@property (nonatomic, assign) CGRect titleFrame;

/** 时间frame */
@property (nonatomic, assign) CGRect timeFrame;

/** 来自frame */
@property (nonatomic, assign) CGRect fromFrame;

/** 正文frame */
@property (nonatomic, assign) CGRect textFrame;

/** vip会员 */
@property (nonatomic, assign) CGRect vipFrame;


/** 图片的frame */
@property (nonatomic, assign) CGRect photoFrame;

 
/** 自身的rect */
@property (nonatomic, assign) CGRect rect;

/** 模型数据 */
@property (nonatomic, strong) JDStatus *status;

@end
