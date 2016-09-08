//
//  JDStatusFrame.h
//  丁丁说
//
//  Created by JiangDing on 15/11/29.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JDStatus,JDDetaiFrame;

@interface JDStatusFrame : NSObject

/** detaiView Frame */
@property (nonatomic, strong) JDDetaiFrame *detailFrame;

/** tabBar Frame */
@property (nonatomic, assign) CGRect tabBarFrame;

/** 一个cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;


/** 模型数据 */
@property (nonatomic, strong) JDStatus *status;

@end
