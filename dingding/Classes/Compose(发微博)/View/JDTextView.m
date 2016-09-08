//
//  JDTextView.m
//  丁丁说
//
//  Created by JiangDing on 15/11/24.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDTextView.h"

@interface JDTextView() <UITextViewDelegate>
@property (nonatomic, weak) UILabel *label;
@end

@implementation JDTextView

- (UILabel *)label
{
    if (_label == nil) {
        UILabel *label =  [[UILabel alloc] init];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:15.0];
        [self addSubview:label];
        self.label = label;
    }
    return _label;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置属性
        self.font = [UIFont systemFontOfSize:15.0];
 
        // 接受通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

// textView改变文字通知
- (void)textChange
{
    self.label.hidden = (self.attributedText.length != 0);
 
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textChange];
}

// 设置
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    self.label.text = placeholder;
 
}

// 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];

    self.label.x = 5;
    self.label.y = 7;
    self.label.width = self.width - self.label.x * 2;
    
    // 设置高度
    //CGSize size = [self.placeholder sizeWithAttributes:@{ NSFontAttributeName : self.label.font}];
    CGSize maxSize = CGSizeMake(self.label.width, MAXFLOAT) ;
    CGRect rect = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : self.label.font } context:nil];
    
    self.label.height = rect.size.height;
}

- (void)dealloc
{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
