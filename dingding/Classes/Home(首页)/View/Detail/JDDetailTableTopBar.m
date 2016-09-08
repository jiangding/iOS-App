//
//  JDDetailTableTopBar.m
//  丁丁说
//
//  Created by JiangDing on 15/12/8.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDDetailTableTopBar.h"
#import "JDStatus.h"


@interface JDDetailTableTopBar()

@property (weak, nonatomic)  UIView *arrowView;
@property (weak, nonatomic)  UIButton *retweetedButton;
@property (weak, nonatomic)  UIButton *commentButton;
@property (weak, nonatomic)  UIButton *attitudeButton;

// 选择的按钮
@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation JDDetailTableTopBar

/**
 *  懒加载
 */
- (UIView *)arrowView
{
    if (_arrowView == nil) {
        UIView *arrowView = [[UIView alloc] init];
        arrowView.backgroundColor = [UIColor orangeColor];
        [self addSubview:arrowView];
        self.arrowView = arrowView;
    }
    return _arrowView;
}


+ (instancetype)toolBar
{
    return [[self alloc] init];
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage strectchImageWithNamed:@"statusdetail_comment_top_background"] drawInRect:rect];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = JDGlobColor;
        
        // 添加单个按钮
        self.retweetedButton = [self addButtonWith:@"转发" tag:JDTabTopBarTypeRetweeted];
        self.commentButton = [self addButtonWith:@"评论" tag:JDTabTopBarTypeComment];
        self.attitudeButton = [self addButtonWith:@"赞" tag:JDTabTopBarTypeZan];
    }
    return self;
}
/**
 *  添加单个按钮
 */
- (UIButton *)addButtonWith:(NSString *)title tag:(JDTabTopBarType)tag
{
    UIButton *btn = [[UIButton alloc] init];
    btn.tag = tag;
    btn.titleLabel.font = JDStatusToolFont;
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    return btn;
}


- (void)setDelegate:(id<JDDetailTableTopBarDelegate>)delegate
{
    _delegate = delegate;
    
    // 默认选中评论
    [self buttonClick:self.commentButton];

}

- (void)buttonClick:(UIButton *)button
{
    // 0. 设置当前按钮类型
    self.selectedButtonType = (int)button.tag;
    
    // 1. 设置按钮点击
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    // 2. 调节底部图片的位置
    [UIView animateWithDuration:0.25 animations:^{
        self.arrowView.centerX = button.centerX;
    }];
 
    // 3. 代理
    if ([self.delegate respondsToSelector:@selector(tableTopBar:DidSelectedBtn:)]) {
        [self.delegate tableTopBar:self DidSelectedBtn:(JDTabTopBarType)button.tag];
    }

}

- (void)setStatus:(JDStatus *)status
{
    _status = status;
 
    [self setButton:self.retweetedButton count:status.reposts_count title:@"转发"];
    [self setButton:self.commentButton count:status.comments_count title:@"评论"];
    [self setButton:self.attitudeButton count:status.attitudes_count title:@"赞"];
 
}

/**
 *  设置按钮显示, 返回宽度
 */
- (void)setButton:(UIButton *)btn count:(int)count title:(NSString *)title
{
    // 判断
    if (count >= 10000) {
        title = [NSString stringWithFormat:@"%@ %.1f万", title , count / 10000.0];
        // 如果后面是0就替换为空
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else{
        title = [NSString stringWithFormat:@"%@ %d", title, count];
    }
 
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateSelected];
 
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    CGFloat width = 80;
    CGFloat height = self.height -2;
    
    int index = 0;
    for (UIView *btn in self.subviews) {
        
        if ([btn isKindOfClass:[UIButton class]]){
            btn.width = width;
            btn.height = height;
            if (btn.tag == JDTabTopBarTypeZan) {
                btn.x = self.width - width;
            }else{
                btn.x = index * width;
            }
            
            btn.y = 0;
            index ++;
        }else{
            btn.x = 90;
            btn.width = 60;
            btn.height = 2;
            btn.y = 42;
        }
        
    }
}


@end
