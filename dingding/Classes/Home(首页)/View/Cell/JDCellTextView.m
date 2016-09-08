//
//  JDCellTextView.m
//  丁丁说
//
//  Created by JiangDing on 15/12/5.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDCellTextView.h"
#import "JDCellLink.h"

#define JDLinkBackgroundTag 10000

@interface JDCellTextView()
@property (nonatomic, weak) UITextView *textView;
/** 所有links模型 */
@property (nonatomic, strong) NSMutableArray *links;
@end
@implementation JDCellTextView

/**
 *  懒加载
 */
- (NSMutableArray *)links
{
    if (_links == nil) {
        NSMutableArray *links = [NSMutableArray array];
        
        // 搜索所有的链接
        [self.attrText enumerateAttributesInRange:NSMakeRange(0, self.attrText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
            
            // 获取自定义属性的值
            NSString *linkText = attrs[JDLink];
            if (linkText == nil) return;
            
            // 创建一个链接
            JDCellLink *link = [[JDCellLink alloc] init];
            link.text = linkText;
            link.range = range;
            
            // 处理矩形框
            NSMutableArray *rects = [NSMutableArray array];
            // 设置选中的字符范围, 设置这个默认计算出了 selectedTextRange
            self.textView.selectedRange = range;
            // 算出选中的字符范围的边框
            NSArray *selectionRects = [self.textView selectionRectsForRange:self.textView.selectedTextRange];
            for (UITextSelectionRect *selectionRect in selectionRects) {
                if (selectionRect.rect.size.width == 0 || selectionRect.rect.size.height == 0) continue;
                [rects addObject:selectionRect];
            }
            link.rects = rects;
            
            [links addObject:link];
        }];
        
        self.links = links;
    }
    return _links;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UITextView *textView = [[UITextView alloc] init];
        // 不能编辑
        textView.editable = NO;
        // 不能滚动
        textView.scrollEnabled = NO;
        // 设置TextView不能跟用户交互
        textView.userInteractionEnabled = NO;
        // 设置文字的内边距
        textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        textView.backgroundColor = [UIColor clearColor];
        [self addSubview:textView];
        self.textView = textView;
    }
    return self;
}


- (void)setAttrText:(NSAttributedString *)attrText
{
    _attrText = attrText;
    
    self.textView.attributedText = attrText;
    
    // 每次设置都重新赋值, 解决重用的问题
    self.links = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textView.frame = self.bounds;
}

#pragma mark - 点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    // 得出被点击的那个链接
    JDCellLink *touchingLink = [self touchingLinkWithPoint:point];
 
    // 显示背景
    [self showLinkBackground:touchingLink];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    // 得出被点击的那个链接
    JDCellLink *touchingLink = [self touchingLinkWithPoint:point];
    if (touchingLink) {
        // 说明手指在某个链接上面抬起来, 发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:JDLinkDidSelectedNotification object:nil userInfo:@{JDLinkText : touchingLink.text}];
    }
    
    // 相当于触摸被取消
    [self touchesCancelled:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 删除所有背景
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeAllLinkBackground];
    });
}


#pragma mark - 链接背景处理
/**
 *  根据触摸点找出被触摸的链接
 *
 *  @param point 触摸点
 */
- (JDCellLink *)touchingLinkWithPoint:(CGPoint)point
{
    __block JDCellLink *touchingLink = nil;
    [self.links enumerateObjectsUsingBlock:^(JDCellLink *link, NSUInteger idx, BOOL *stop) {
        for (UITextSelectionRect *selectionRect in link.rects) {
            if (CGRectContainsPoint(selectionRect.rect, point)) {
                touchingLink = link;
                break;
            }
        }
    }];
    return touchingLink;
}

/**
 *  显示链接的背景
 *
 *  @param link 需要显示背景的link
 */
- (void)showLinkBackground:(JDCellLink *)link
{
    for (UITextSelectionRect *selectionRect in link.rects) {
        UIView *bg = [[UIView alloc] init];
        bg.tag = JDLinkBackgroundTag;
        bg.layer.cornerRadius = 3;
        bg.frame = selectionRect.rect;
        bg.backgroundColor = JDColor(170, 227, 240);
        // 添加背景到后面
        [self insertSubview:bg atIndex:0];
    }
}

- (void)removeAllLinkBackground
{
    // 遍历子控件
    for (UIView *child in self.subviews) {
        if (child.tag == JDLinkBackgroundTag) {
            [child removeFromSuperview];
        }
    }
}



@end
