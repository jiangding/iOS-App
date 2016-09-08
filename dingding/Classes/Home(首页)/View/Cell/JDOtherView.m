//
//  JDOtherView.m
//  丁丁说
//
//  Created by JiangDing on 15/11/29.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDOtherView.h"
#import "JDOtherFrame.h"
#import "JDStatus.h"
#import "JDUser.h"
#import "JDPhotosView.h"
#import "JDCellTextView.h"

@interface JDOtherView()
//@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) JDCellTextView *textLabel;
@property (nonatomic, weak) JDPhotosView *photosView;
@end

@implementation JDOtherView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage strectchImageWithNamed:@"timeline_retweet_background"];
        self.highlightedImage = [UIImage strectchImageWithNamed:@"timeline_retweet_background_highlighted"];
        
        // 1. 添加标题label
//        UILabel *title = [[UILabel alloc] init];
//        title.textColor =  JDStatusHightColor;
//        title.font = JDStatusTextFont;
//        [self addSubview:title];
//        self.titleLabel = title;
        

        // 2. 添加正文
        JDCellTextView *text = [[JDCellTextView alloc] init];
        [self addSubview:text];
        self.textLabel = text;
        
        
        // 3. 添加相册
        JDPhotosView *photosView = [[JDPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
}


- (void)setOtherFrame:(JDOtherFrame *)otherFrame
{
    _otherFrame = otherFrame;
    
    self.frame = otherFrame.rect;
    
    // 1. 标题
//    self.titleLabel.text = [NSString stringWithFormat:@"@%@", otherFrame.retweetedStatus.user.name];
//    self.titleLabel.frame = otherFrame.titleFrame;
    
    // 2. 转发正文
    // 设置文字
    self.textLabel.attrText = otherFrame.retweetedStatus.attrText;
    self.textLabel.frame = otherFrame.textFrame;
    
    
    // 3. 相册
    if (otherFrame.retweetedStatus.pic_urls.count) {
        self.photosView.photos = otherFrame.retweetedStatus.pic_urls;
        self.photosView.frame = otherFrame.photoFrame;
        self.photosView.hidden = NO;
    }else{
        self.photosView.hidden = YES;
    }
    
}

@end
