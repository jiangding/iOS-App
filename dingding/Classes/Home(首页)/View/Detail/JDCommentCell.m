//
//  JDCommentCell.m
//  丁丁说
//
//  Created by JiangDing on 15/12/9.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDCommentCell.h"
#import "JDCommentCellView.h"
#import "JDComment.h"
#import "JDCommentFrame.h"

@interface JDCommentCell()

@property (nonatomic, weak)JDCommentCellView *cellView;

@property (nonatomic, weak) UIButton *zanBtn;

@end

@implementation JDCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
 
        // 添加一个detailView
        JDCommentCellView *cellView = [[JDCommentCellView alloc] init];
        [self.contentView addSubview:cellView];
        self.cellView = cellView;
        
        // 赞
        UIButton *zanBtn = [[UIButton alloc] init];
        [zanBtn setImage:[UIImage imageNamed:@"statusdetail_comment_icon_like"] forState:UIControlStateNormal];
        [zanBtn setImage:[UIImage imageNamed:@"statusdetail_comment_icon_like_highlighted"] forState:UIControlStateSelected];
        zanBtn.width = 50;
        zanBtn.height = 50;
        [zanBtn addTarget:self action:@selector(zanClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:zanBtn];
        self.zanBtn = zanBtn;
 
        // 设置cell背景
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage strectchImageWithNamed:@"common_card_background"]];
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage strectchImageWithNamed:@"common_card_middle_background_highlighted"]];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"commentCell";
    
    JDCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[JDCommentCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}


- (void)setCommentFrame:(JDCommentFrame *)commentFrame
{
    _commentFrame = commentFrame;

    // 设置数据
    self.cellView.commentFrame = commentFrame;
    
    self.zanBtn.x = JDScreenWidth - self.zanBtn.height - JDMarin10;
}
/**
 *  赞点击
 */
- (void)zanClick:(UIButton *)btn
{
    btn.selected = !btn.isSelected;
 
    if (btn.selected) {
        [UIView animateWithDuration:0.5 animations:^{
            [btn setTitle:@"+1" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            CGAffineTransform scale = CGAffineTransformMakeScale(0.5, 0.5);
            btn.imageView.transform = CGAffineTransformTranslate(scale, 30, 0);
            
        }];
    }else{
        [btn setTitle:nil forState:UIControlStateNormal];
        btn.imageView.transform = CGAffineTransformIdentity;
    }
 
}

@end
