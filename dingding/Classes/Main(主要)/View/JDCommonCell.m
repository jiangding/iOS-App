//
//  JDCommonCell.m
//  丁丁说
//
//  Created by JiangDing on 15/12/7.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDCommonCell.h"
#import "JDCommonItem.h"
#import "JDBadgeView.h"
#import "JDCommonArrow.h"
#import "JDCommonLabel.h"
#import "JDCommonSwitch.h"

@interface JDCommonCell()
/** 提醒数字 */
@property (nonatomic, strong) JDBadgeView *badgeValue;
/** 右边> */
@property (nonatomic, strong) UIImageView *rightArrow;
/** 开关 */
@property (nonatomic, strong) UISwitch *switcher;
/** 右边的标签 */
@property (nonatomic, strong) UILabel *rightLabel;
@end
@implementation JDCommonCell

/**
 *  懒加载
 */
- (JDBadgeView *)badgeValue
{
    if (_badgeValue == nil) {
        _badgeValue = [[JDBadgeView alloc] init];
    }
    return _badgeValue;
}
- (UIImageView *)rightArrow
{
    if (_rightArrow == nil) {
        self.rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _rightArrow;
}
- (UISwitch *)switcher
{
    if (_switcher == nil) {
        self.switcher = [[UISwitch alloc] init];
    }
    return _switcher;
}
- (UILabel *)rightLabel
{
    if (_rightLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor lightGrayColor];
        label.font = JDStatusTextFont;
        self.rightLabel = label;
    }
    return _rightLabel;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 设置标题的字体
        self.textLabel.font = [UIFont boldSystemFontOfSize:16];
        self.detailTextLabel.font = [UIFont systemFontOfSize:11];
        
        // 去除cell的默认背景色
        self.backgroundColor = [UIColor clearColor];
    
        // 设置背景view
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
    }
    
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"commonID";
    
    JDCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[JDCommonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
 
    return cell;
}

// 设置数据
- (void)setItem:(JDCommonItem *)item
{
    _item = item;
    
    self.textLabel.text = item.title;
    self.imageView.image = item.icon;
    self.detailTextLabel.text = item.subTitle;
    
    // 判断
    if (item.badgeValue) { // 最高权限,右边有提醒数字
        self.badgeValue.badge = item.badgeValue;
        self.accessoryView = self.badgeValue;
    }else if ([item isKindOfClass:[JDCommonArrow class]]){
        self.accessoryView = self.rightArrow;
    }else if ([item isKindOfClass:[JDCommonSwitch class]]){
        self.accessoryView = self.switcher;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if ([item isKindOfClass:[JDCommonLabel class]]){
        // 转
        JDCommonLabel *labelItem = (JDCommonLabel *)item;
        // 设置文字
        self.rightLabel.text = labelItem.text;
        // 根据文字计算尺寸
        CGSize size =  [labelItem.text sizeWithAttributes:@{NSFontAttributeName:self.rightLabel.font}];
        self.rightLabel.width = size.width;
        self.rightLabel.height = size.height;
        self.accessoryView = self.rightLabel;
 
    }else{
        self.accessoryView = nil;
    }
    
}

- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(NSInteger)rows
{
    // 1.取出背景view
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selectedBgView = (UIImageView *)self.selectedBackgroundView;
    
    // 2.设置背景图片
    if (rows == 1) {
        bgView.image = [UIImage strectchImageWithNamed:@"common_card_background"];
        selectedBgView.image = [UIImage strectchImageWithNamed:@"common_card_background_highlighted"];
    } else if (indexPath.row == 0) { // 首行
        bgView.image = [UIImage strectchImageWithNamed:@"common_card_top_background"];
        selectedBgView.image = [UIImage strectchImageWithNamed:@"common_card_top_background_highlighted"];
    } else if (indexPath.row == rows - 1) { // 末行
        bgView.image = [UIImage strectchImageWithNamed:@"common_card_bottom_background"];
        selectedBgView.image = [UIImage strectchImageWithNamed:@"common_card_bottom_background_highlighted"];
    } else { // 中间
        bgView.image = [UIImage strectchImageWithNamed:@"common_card_middle_background"];
        selectedBgView.image = [UIImage strectchImageWithNamed:@"common_card_middle_background_highlighted"];
    }
 
}

// 布局子控件的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 5;
    self.detailTextLabel.y -= 2;
}

@end
