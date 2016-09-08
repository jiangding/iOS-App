//
//  JDEmotionAttachment.m
//  丁丁说
//
//  Created by JiangDing on 15/12/4.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDEmotionAttachment.h"
#import "JDEmotion.h"

@implementation JDEmotionAttachment

/**
 *  初始方法
 */
+ (instancetype)attach
{
    return [[self alloc] init];
}

- (void)setEmotion:(JDEmotion *)emotion
{
    _emotion = emotion;
 
    self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", emotion.founder, emotion.png]];

}


@end
