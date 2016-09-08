//
//  JDMeView.m
//  丁丁说
//
//  Created by JiangDing on 15/11/29.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDMeView.h"
#import "JDMeFrame.h"
#import "JDStatus.h"
#import "JDUser.h"
#import "JDPhotosView.h"

#import "UIImageView+WebCache.h"
#import "JDCellTextView.h"

@interface JDMeView()

@property (nonatomic, weak) UIImageView *icon;
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UILabel *time;
@property (nonatomic, weak) UILabel *from;
@property (nonatomic, weak) JDCellTextView *text;
@property (nonatomic, weak) UIImageView *vip;

/** 图片相册 */
@property (nonatomic, weak) JDPhotosView *photosView;
@end

@implementation JDMeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 我的微博里面分为几个部分
        
        // 1. 头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTap:)];
        [iconView addGestureRecognizer:gesture];
        self.icon = iconView;
        
        // 2. 标题
        UILabel *titleView = [[UILabel alloc] init];
        titleView.font = JDStatusNameFont;
        [self addSubview:titleView];
        self.title = titleView;
        
        // 2.5 vip
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.hidden = YES;
        [self addSubview:vipView];
        self.vip = vipView;
        
        // 3. 时间
        UILabel *timeView = [[UILabel alloc] init];
        timeView.font = JDStatusTimeFont;
        timeView.textColor = [UIColor orangeColor];
        [self addSubview:timeView];
        self.time = timeView;
        
        // 4. 来自
        UILabel *fromView = [[UILabel alloc] init];
        fromView.font = JDStatusSourceFont;
        fromView.textColor = [UIColor lightGrayColor];
        [self addSubview:fromView];
        self.from = fromView;
        
        // 5. 正文
        JDCellTextView *textView = [[JDCellTextView alloc] init];
//        textView.numberOfLines = 0;
//        textView.font = JDStatusTextFont;
        [self addSubview:textView];
        self.text = textView;
        
        // 6. 图片相册
        JDPhotosView *photosView = [[JDPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
    }
    return self;
}


- (void)setMeFrame:(JDMeFrame *)meFrame
{
    _meFrame = meFrame;
    
    self.frame = meFrame.rect;
    
    // 获取数据
    JDStatus *status = meFrame.status;
    JDUser *user = status.user;
 
    // 1. 头像
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.icon.layer.cornerRadius = 20;
    self.icon.layer.masksToBounds= YES;
    self.icon.frame = meFrame.iconFrame;
    
    // 2. 标题
    self.title.text = user.name;
    self.title.frame = meFrame.titleFrame;
    
    // 2.5 vip会员
    if (user.isVip) {
        self.vip.hidden = NO;
        self.vip.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
        self.vip.frame = meFrame.vipFrame;
        self.title.textColor = JDColor(237, 133, 103);
    }else{
        self.vip.hidden = YES;
        self.title.textColor = [UIColor blackColor];
    }

    // 3. 时间
    self.time.text = status.created_at;
    CGFloat timeX = CGRectGetMaxX(self.icon.frame) + JDMarin10;
    CGFloat timeY = CGRectGetMaxY(self.title.frame)+ JDMarin5;
    CGSize timeSize = [status.created_at sizeWithAttributes:@{NSFontAttributeName : JDStatusTimeFont}];
    CGFloat timeW = timeSize.width;
    CGFloat timeH = timeSize.height;
    self.time.frame = CGRectMake(timeX, timeY, timeW, timeH);
 
    // 4. 来自
    self.from.text = status.source;
    CGFloat fromX = CGRectGetMaxX(self.time.frame) + JDMarin10;
    CGFloat fromY = CGRectGetMaxY(self.title.frame) + JDMarin5;
    CGSize fromSize = [status.source sizeWithAttributes:@{NSFontAttributeName : JDStatusSourceFont}];
    CGFloat fromW = fromSize.width;
    CGFloat fromH = fromSize.height;
    self.from.frame = CGRectMake(fromX, fromY, fromW, fromH);

    
    // 5. 正文
    //self.text.text = status.text;
    self.text.attrText = status.attrText;
    self.text.frame = meFrame.textFrame;
    
 
    // 6. 图片相册
    if (status.pic_urls.count) {
        self.photosView.photos = status.pic_urls;
        self.photosView.frame = meFrame.photoFrame;
        self.photosView.hidden = NO;
    }else{
        self.photosView.hidden = YES;
    }

}

/**
 *  头像点击事件
 */
- (void)iconTap:(UIGestureRecognizer *)recognizer
{
    JDLog(@"11");
}


@end
