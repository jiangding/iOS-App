//
//  JDDetailView.m
//  丁丁说
//
//  Created by JiangDing on 15/11/29.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDDetailView.h"
#import "JDMeView.h"
#import "JDOtherView.h"
#import "JDDetaiFrame.h"
#import "JDStatus.h"

@interface JDDetailView()

@property (nonatomic, weak) JDMeView *meView;

@property (nonatomic, weak) JDOtherView *otherView;

@end

@implementation JDDetailView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage strectchImageWithNamed:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage imageNamed:@"timeline_card_top_background_highlighted"];
        
        // 吧这个detailView 分为2部分
        
        // 1. 我的微博
        JDMeView *meView = [[JDMeView alloc] init];
        [self addSubview:meView];
        self.meView = meView;
        
        // 2. 转发微博
        JDOtherView *otherView = [[JDOtherView alloc] init];
        [self addSubview:otherView];
        self.otherView = otherView;
        
    }
    return self;
}

// 设置
- (void)setDetaiFrame:(JDDetaiFrame *)detaiFrame
{
    _detaiFrame = detaiFrame;
    
    self.frame = detaiFrame.rect;
    
    // 1. 设置我的微博
    self.meView.meFrame = detaiFrame.meFrame;
 
#warning  如果转发微博为nil，这里判断的话就会出大错， cell重用到时候会出错
//    if (detaiFrame.status.retweeted_status) {
    // 2. 转发微博
    self.otherView.otherFrame = detaiFrame.otherFrame;
   // }
    
}


@end
