//
//  JDDetailTableCover.m
//  丁丁说
//
//  Created by JiangDing on 15/12/11.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDDetailTableCover.h"

@interface JDDetailTableCover()

@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UIActivityIndicatorView *activity;

@end
@implementation JDDetailTableCover

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 添加一个label
        UILabel *label = [[UILabel alloc] init];
        label.font = JDStatusNameFont;
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        self.label = label;
        
        // 添加一个转圈圈
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activity.backgroundColor = JDRandomColor;

        [activity setHidesWhenStopped:YES]; //当旋转结束时隐藏
        [activity startAnimating];
        [self addSubview:activity];
        self.activity = activity;
    }
    return self;
}

- (void)setText:(NSString *)text
{
    _text = text;
    
    self.label.text = text;
    
    // 停止转圈圈
    [self.activity stopAnimating];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置label的位置
    CGFloat labelW = 200;
    CGFloat labelH = 50;
    CGFloat labelX = (self.width - labelW) * 0.5;
    CGFloat labelY = 20;
    self.label.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
    // 设置圈圈位置
    CGFloat w = 100;
    CGFloat h = 50;
    CGFloat x = (self.width - w) * 0.5;
    CGFloat y = 0;
    self.activity.frame = CGRectMake(x, h, x, y);
 
}

@end
