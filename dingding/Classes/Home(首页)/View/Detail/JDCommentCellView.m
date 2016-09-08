//
//  JDCommentCellView.m
//  丁丁说
//
//  Created by JiangDing on 15/12/10.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDCommentCellView.h"
#import "JDComment.h"
#import "JDCommentFrame.h"
#import "JDUser.h"
#import "NSDate+JD.h"
#import "UIImageView+WebCache.h"
#import "JDCommentCell.h"

@interface JDCommentCellView()

// 1. 头像
@property (nonatomic, weak) UIImageView *iconView;

// 2. 标题
@property (nonatomic, weak) UILabel *titleView;

// 2.5 vip
@property (nonatomic, weak) UIImageView *vip;

// 3. 时间
@property (nonatomic, weak) UILabel *timeView;

// 4. 赞
@property (nonatomic, weak) UIButton *zanBtn;

// 5. 正文
@property (nonatomic, weak) UILabel *textView;

@end

@implementation JDCommentCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 1. 添加icon
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.layer.cornerRadius = 18;
        iconView.clipsToBounds = YES;
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 2. 添加标题
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = JDCommentTitleFont;
        [self addSubview:titleLabel];
        self.titleView = titleLabel;
        
        // 2.5 vip
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.hidden = YES;
        [self addSubview:vipView];
        self.vip = vipView;
        
        // 3. 时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = [UIColor lightGrayColor];
        timeLabel.font = JDCommentTimeFont;
        [self addSubview:timeLabel];
        self.timeView = timeLabel;
        
//        // 4. 赞
//        UIButton *zanBtn = [[UIButton alloc] init];
//        [zanBtn setImage:[UIImage imageNamed:@"statusdetail_comment_icon_like"] forState:UIControlStateNormal];
//        [zanBtn setImage:[UIImage imageNamed:@"statusdetail_comment_icon_like_highlighted"] forState:UIControlStateHighlighted];
//        zanBtn.backgroundColor = JDRandomColor;
//        [zanBtn sizeToFit];
//        [zanBtn addTarget:self action:@selector(zanClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:zanBtn];
//        self.zanBtn = zanBtn;
    
        // 5. 正文
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.numberOfLines = 0;
        textLabel.font = JDCommentTextFont;
        [self addSubview:textLabel];
        self.textView = textLabel;
 
    }
    return self;
}


- (void)setCommentFrame:(JDCommentFrame *)commentFrame
{
    _commentFrame = commentFrame;
    
    // 获得comment
    JDComment *comment = commentFrame.comment;
    
    // 设置frame
    // 1. 设置数据和frame
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame = commentFrame.iconF;

    // 2. 设置标题数据和frame
    self.titleView.text = comment.user.name;
    self.titleView.frame = commentFrame.titleF;
    
    // 2.5
    if (comment.user.isVip) {
        self.vip.hidden = NO;
        self.vip.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",comment.user.mbrank]];
        self.vip.frame = commentFrame.vipF;
        self.titleView.textColor = JDColor(237, 133, 103);
    }else{
        self.titleView.textColor = [UIColor blackColor];
        self.vip.hidden = YES;
    }
 

    // 3. 计算时间
    NSString *date = [NSDate dateFormat:comment.created_at];
    self.timeView.text = date;
    self.timeView.frame = commentFrame.timeF;
   
    // 4. 赞
    self.zanBtn.x = JDScreenWidth - self.zanBtn.height - JDMarin10;
    self.zanBtn.y = self.titleView.y;
 
    // 5. 正文
    self.textView.attributedText = comment.attrText;
    self.textView.frame = commentFrame.textF;
}

///**
// *  赞点击
// */
//- (void)zanClick:(UIButton *)btn
//{
//    JDLog(@"za");
//}

@end
