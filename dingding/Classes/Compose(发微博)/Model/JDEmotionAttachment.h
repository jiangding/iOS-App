//
//  JDEmotionAttachment.h
//  丁丁说
//
//  Created by JiangDing on 15/12/4.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDEmotion;

@interface JDEmotionAttachment : NSTextAttachment

/** emotion模型 */
@property (nonatomic, strong) JDEmotion *emotion;

/**
 *  初始方法
 */
+ (instancetype)attach;

@end
