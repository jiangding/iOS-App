//
//  JDTabBarView.m
//  丁丁说
//
//  Created by JiangDing on 15/11/29.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDTabBarView.h"
#import "JDStatus.h"
#import "JDDetailController.h"

@interface JDTabBarView()

@property (nonatomic, strong) NSMutableArray *lines;
@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, weak) UIButton *reportsBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;

@end

@implementation JDTabBarView
/**
 *  懒加载
 */
- (NSMutableArray *)lines
{
    if (_lines == nil) {
        _lines = [NSMutableArray array];
    }
    return _lines;
}
- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
 
        self.userInteractionEnabled = YES;
        self.image = [UIImage strectchImageWithNamed:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage strectchImageWithNamed:@"timeline_card_bottom_background_highlighted"];
        
        // 添加三个按钮
        self.reportsBtn = [self addButtonWithImage:@"timeline_icon_retweet" title:@"转发"];
        self.commentBtn = [self addButtonWithImage:@"timeline_icon_comment" title:@"评论"];
        self.attitudeBtn = [self addButtonWithImage:@"timeline_icon_unlike" title:@"赞"];
        
        // 添加两个线
        [self addOneLine];
        [self addOneLine];
    }
    return self;
}

// 设置数据
- (void)setStatus:(JDStatus *)status
{
    _status = status;
    
    // 此时设置数据
    [self setCount:status.reposts_count button:self.reportsBtn];
    [self setCount:status.comments_count button:self.commentBtn];
    [self setCount:status.attitudes_count button:self.attitudeBtn];
 
}

/**
  重设数据
 */
- (void)setCount:(int)count button:(UIButton *)btn
{
    // 不做改变
    if (count <= 0) return;
 
    // 更改格式
    NSString *title;
    if (count > 10000) {
        // 四舍五入截取后面的数字
        title = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
        // 如果后面是.0就替换
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else{
        title = [NSString stringWithFormat:@"%d", count];
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
}


/**
 *  添加按钮方法
 */
- (UIButton *)addButtonWithImage:(NSString *)icon title:(NSString *)title
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage strectchImageWithNamed:@"common_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = JDStatusToolFont;
    btn.adjustsImageWhenHighlighted = NO;
 
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
  
    [self addSubview:btn];
    [self.buttons addObject:btn];
    
    return btn;
}

/**
 *  添加一个线
 */
- (void)addOneLine
{
    UIImageView *view = [[UIImageView alloc] init];
    view.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    view.contentMode = UIViewContentModeCenter;
    [self addSubview:view];
    [self.lines addObject:view];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 布局按钮
    int btnCount = (int)self.buttons.count;
    CGFloat width = self.width / btnCount;
    
    for (int i = 0; i < btnCount; i++) {
        UIButton *btn = self.buttons[i];
        btn.x = i * width;
        btn.y = 0;
        btn.width = width;
        btn.height = self.height;
    }

    
    // 布局线
    int j = 1;
    for (UIImageView *v in  self.lines) {
        v.x = j * width;
        v.y = 0;
        v.width = 1;
        v.height = self.height;
        
        j++;
    }
    
}

/**
 1.小于1W ： 具体数字，比如9800，就显示9800
 2.大于等于1W：xx.x万，比如78985，就显示7.9万
 3.整W：xx万，比如800365，就显示80万
 */

- (void)btnClick:(UIButton *)btn
{
    if (btn == self.attitudeBtn) {
        [btn setImage:[UIImage imageNamed:@"statusdetail_comment_icon_like_highlighted"] forState:UIControlStateSelected];
        btn.selected = !btn.isSelected;
        
        // 数字+1
        int zanCount =  [self.attitudeBtn.titleLabel.text intValue];
        zanCount = btn.selected ? (zanCount + 1) : (zanCount - 1);
        [self setCount:zanCount button:self.attitudeBtn];
        // 动画
        [UIView animateWithDuration:0.5 animations:^{
            btn.imageView.transform = CGAffineTransformMakeScale(0.5, 0.5);
         
        } completion:^(BOOL finished) {
            btn.imageView.transform = CGAffineTransformIdentity;
        }];

    }else if (btn == self.commentBtn){
        
        // 如果当前评论不为0
        if (self.status.comments_count != 0) {
            // 发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:JDStatusCommentClickNotification object:self userInfo:@{ @"status" : self.status}];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:JDStatusCommentClickZeroNotification object:self userInfo:@{@"comId" : self.status.idstr}];
        }

    }

}

@end
