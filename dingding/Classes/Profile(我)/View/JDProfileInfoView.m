//
//  JDProfileInfoView.m
//  丁丁说
//
//  Created by JiangDing on 15/12/11.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDProfileInfoView.h"

@interface JDProfileInfoView()

/** 左边图片 */
@property (nonatomic, weak) UIImageView *iconV;

/** 姓名 */
@property (nonatomic, weak) UILabel *nameLabel;

/** 开通会员 */
@property (nonatomic, weak) UIImageView *vipV;

/** 简介 */
@property (nonatomic, weak) UILabel *desc;

@property (nonatomic, weak) UIImageView *inV;


@property (nonatomic, weak) UIImageView *touchBgView;

@end

@implementation JDProfileInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = JDGlobColor;
        // 1. 添加左边图片
        UIImageView *iconV = [[UIImageView alloc] init];
        iconV.image = [UIImage imageNamed:@"head"];
        iconV.layer.cornerRadius = 20;
        iconV.clipsToBounds = YES;
        [self addSubview:iconV];
        self.iconV = iconV;
        
        // 2. 姓名
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.text = @"明天先去";
        nameLabel.font = [UIFont boldSystemFontOfSize:15.0];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 3. vip图片
        UIImageView *vipV = [[UIImageView alloc] init];
        vipV.image = [UIImage imageNamed:@"userinfo_membership_expired"];
        [vipV sizeToFit];
        [self addSubview:vipV];
        self.vipV = vipV;
        
        // 4. 简介
        UILabel *desc = [[UILabel alloc] init];
        desc.text = @"简介:每个人都是一样的, 只是佩戴的标签不同";
        desc.font = JDStatusTimeFont;
        desc.textColor = [UIColor lightGrayColor];
        [self addSubview:desc];
        self.desc = desc;
        
        // 5. >图片
        UIImageView *inV = [[UIImageView alloc] init];
        inV.image = [UIImage imageNamed:@"common_icon_arrow"];
        [inV sizeToFit];
        [self addSubview:inV];
        self.inV = inV;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage strectchImageWithNamed:@"common_card_bottom_background"] drawInRect:rect];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.width = self.width;
    imageV.height = self.height + 1;
    imageV.y = -2;
    imageV.image = [UIImage strectchImageWithNamed:@"common_card_background_highlighted"];
    [self insertSubview:imageV atIndex:0];
    self.touchBgView = imageV;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.touchBgView removeFromSuperview];
    });
 
    // 发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:JDProfileNotificationPersonCenter object:nil];

}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.2 animations:^{
        [self.touchBgView removeFromSuperview];
    }];

}

- (void)layoutSubviews
{
    // 1. 头像Frame
    CGFloat iconX = 15;
    CGFloat iconY = iconX;
    CGFloat iconW = 50;
    CGFloat iconH = iconW;
    self.iconV.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 2. 标题frame
    self.nameLabel.x = CGRectGetMaxX(self.iconV.frame) + 15;
    self.nameLabel.y = 20;
    self.nameLabel.width = 60;
    self.nameLabel.height = 20;
    
    // 3.
    self.vipV.x = CGRectGetMaxX(self.nameLabel.frame);
    self.vipV.y = self.nameLabel.y;
    
    
    // 5. >
    self.inV.x = self.width - self.inV.width - 15;
    self.inV.y = (self.height - self.inV.height) * 0.5;
    
    // 4.
    self.desc.x = self.nameLabel.x;
    self.desc.y = CGRectGetMaxY(self.nameLabel.frame) + JDMarin5;
    self.desc.width = self.inV.x - self.desc.x - 10;
    self.desc.height = 15;
 
}


@end
