//
//  JDDetailController.h
//  丁丁说
//
//  Created by JiangDing on 15/12/8.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDStatus;

@interface JDDetailController : UIViewController

/** 接收status数据字段 */
@property (nonatomic, strong) JDStatus *status;
@end
