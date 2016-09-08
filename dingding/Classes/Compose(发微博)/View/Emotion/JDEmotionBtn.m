//
//  JDEmotionBtn.m
//  丁丁说
//
//  Created by JiangDing on 15/12/3.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDEmotionBtn.h"
#import "JDEmotion.h"

@implementation JDEmotionBtn
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
}

- (void)setEmotion:(JDEmotion *)emotion
{
    _emotion = emotion;
    
    // 如果是emoji
    if(emotion.code){
        // 设置emoji尺寸
        self.titleLabel.font = [UIFont systemFontOfSize:32.0];
        [self setTitle:emotion.emoji forState:UIControlStateNormal];
        
        // 设置按钮内容为nil
        [self setImage:nil forState:UIControlStateNormal];
        
    }else{
        NSString *icon = [NSString stringWithFormat:@"%@/%@", emotion.founder, emotion.png];
        [self setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
        
        [self setTitle:nil forState:UIControlStateNormal];
    }
 
}

@end
