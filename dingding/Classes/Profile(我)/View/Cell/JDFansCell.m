//
//  JDFansCell.m
//  丁丁说
//
//  Created by JiangDing on 15/12/15.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDFansCell.h"
#import "JDUser.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+MJ.h"
#import "UIAlertView+Block.h"

@interface JDFansCell()
// 头像
@property (nonatomic, weak) UIImageView *iconView;
// 标题
@property (nonatomic, weak) UILabel *titleLabel;
// vip
@property (nonatomic, weak) UIImageView *vip;
// 个人描述
@property (nonatomic, weak) UILabel *descLabel;
// 按钮点击
@property (nonatomic, weak) UIButton *followBtn;
@end

@implementation JDFansCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 1. 头像图片
        UIImageView *iconV = [[UIImageView alloc] init];
        iconV.layer.cornerRadius = 40;
        iconV.layer.masksToBounds = YES;
        [self.contentView addSubview:iconV];
        self.iconView = iconV;
        
        // 2. 标题
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = JDFont17;
        titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;

        // 3. vip图片
        UIImageView *vip = [[UIImageView alloc] init];
        [vip sizeToFit];
        vip.hidden = YES;
        [self.contentView addSubview:vip];

        self.vip = vip;

        // 4. 描述文字
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.font = JDFont13;
        descLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:descLabel];
        self.descLabel = descLabel;
        
        // 5. 关注按钮
        UIButton *btn = [[UIButton alloc] init];
        [btn setBackgroundImage:[UIImage imageNamed:@"common_relationship_button_background"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"common_relationship_button_background_highlighted"] forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:@"navigationbar_friendattention_dot_highlighted"] forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        [btn addTarget:self action:@selector(followBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.followBtn = btn;
        
        
        // 设置cell背景
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage strectchImageWithNamed:@"common_card_background"]];
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage strectchImageWithNamed:@"common_card_middle_background_highlighted"]];
        
    }
    return self;
}

- (void)followBtn:(UIButton *)followBtn
{
   UIAlertView *alertView =  [[UIAlertView alloc] initWithTitle:@"关注" message:@"确定要关注此人?" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView showWithBlock:^(NSInteger buttonIndex) {
        if (buttonIndex) {
            [MBProgressHUD showSuccess:@"关注成功"];
        }
    }];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"fansCell";
    
    JDFansCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[JDFansCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}

// 设置数据
- (void)setUser:(JDUser *)user
{
    _user = user;
    
    // 1. 头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.avatar_large] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    CGFloat iconX = JDMarin10 + JDMarin5;
    CGFloat iconY = JDMarin10;
    CGFloat iconW = 80;
    CGFloat iconH = iconW;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
 
    
    // 5. 设置按钮位置
    CGFloat btnW = 40;
    CGFloat btnH = 30;
    CGFloat btnX = JDScreenWidth - btnW - JDMarin10;
    CGFloat btnY = JDMarin10 * 2;
    self.followBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    
    // 2. 标题
    self.titleLabel.text = user.name;
    CGFloat titleX = CGRectGetMaxX(self.iconView.frame) + JDMarin10;
    CGFloat titleY = iconY + JDMarin5;
    // 计算文字尺寸
    CGFloat titleW = btnX - titleX - 30;
    CGFloat titleH = 20;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    
    // 3. 设置vip图片
    if (_user.isVip) {
        self.vip.hidden = NO;
        self.vip.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d", _user.mbrank]];
        self.vip.x = CGRectGetMaxX(self.titleLabel.frame);
        self.vip.y = titleY;
        self.vip.width = 16;
        self.vip.height = 16;
        self.titleLabel.textColor = JDColor(237, 133, 103);
    }else{
        self.vip.hidden = YES;
        self.titleLabel.textColor = [UIColor blackColor];
    }
    
    // 4. 设置个人描述
    self.descLabel.text = user.desc;
    CGFloat descX = titleX;
    CGFloat descY = CGRectGetMaxY(self.titleLabel.frame) + JDMarin5;
    // 计算文字尺寸
    CGFloat descW = btnX - titleX - JDMarin10;
    CGFloat descH = 20;
    self.descLabel.frame = CGRectMake(descX, descY, descW ,descH);

    
}

@end
