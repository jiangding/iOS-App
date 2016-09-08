//
//  JDEmotionTextView.h
//  丁丁说
//
//  Created by JiangDing on 15/12/4.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDTextView.h"
#import "JDEmotion.h"

@interface JDEmotionTextView : JDTextView


/**
 *  拼接表情到最后
 */
- (void)appendEmotion:(JDEmotion *)emotion;

/**
 *  具体的文本数据, 用来转换emoji图标和发给服务器的[哈哈]格式;
 */
- (NSString *)realText;

@end
