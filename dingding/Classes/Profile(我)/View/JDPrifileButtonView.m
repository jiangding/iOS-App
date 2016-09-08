//
//  JDPrifileButtonView.m
//  丁丁说
//
//  Created by JiangDing on 15/12/10.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDPrifileButtonView.h"

@implementation JDPrifileButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = JDGlobColor;
        
        
        // 添加三个按钮
        [self addButtonWithTitle:@"微博" count:@"68"];
        [self addButtonWithTitle:@"关注" count:@"286"];
        [self addButtonWithTitle:@"粉丝" count:@"64"];
 
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage strectchImageWithNamed:@"common_card_bottom_background"] drawInRect:rect];
}

/**
 *  添加按钮
 *
 *  @param title 标题
 *  @param count 数目
 */
- (void)addButtonWithTitle:(NSString *)title count:(NSString *)count
{
 
    NSString *string = [NSString stringWithFormat:@"%@\n%@", count,title];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:[string rangeOfString:count]];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:[string rangeOfString:title]];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:[string rangeOfString:title]];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.attributedText = attrString;
 
    [self addSubview:titleLabel];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    int i = 0;
    for (UIView *label in self.subviews) {
        label.width = self.width / self.subviews.count;
        label.height = 40;
        label.y = 2;
        label.x = i * label.width;
        i++;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    // 触摸点
    CGPoint point = [touch locationInView:touch.view];
 
    // 查看触摸点在那个label里面
    __block UILabel *lab = nil;
    [self.subviews enumerateObjectsUsingBlock:^(UILabel * label, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(label.frame, point)) {
            lab = label;
            *stop = YES;
        }
    }];
    
    NSArray *arr = [lab.text componentsSeparatedByString:@"\n"];
    // 然后现在发出通知
    [[NSNotificationCenter defaultCenter]postNotificationName:JDProfileNotificationWGF object:nil userInfo:@{JDProfileWGF : arr[1]}];
 
}

@end
