//
//  JDOtherFrame.m
//  丁丁说
//
//  Created by JiangDing on 15/11/29.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDOtherFrame.h"
#import "JDStatus.h"
#import "JDUser.h"
#import "JDPhotosView.h"

@implementation JDOtherFrame


/** 设置数据 */
- (void)setRetweetedStatus:(JDStatus *)retweetedStatus
{
    _retweetedStatus = retweetedStatus;
    
    // 1. 标题
//    CGFloat titleX = JDMarin10;
//    CGFloat titleY = JDMarin10;
//    CGSize titleSize = [[NSString stringWithFormat:@"@%@", retweetedStatus.user.name] sizeWithAttributes:@{NSFontAttributeName : JDStatusTextFont}];
//    CGFloat titleW = titleSize.width;
//    CGFloat titleH = titleSize.height;
//    self.titleFrame = CGRectMake(titleX, titleY, titleW, titleH);
    
    // 2. 正文
    CGFloat textX = JDMarin10;
    CGFloat textY = JDMarin10;
    CGSize maxSize = CGSizeMake(JDScreenWidth - 2 * textX, MAXFLOAT);
 
    CGRect textRect = [retweetedStatus.attrText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];

    CGFloat textW = textRect.size.width;
    CGFloat textH = textRect.size.height;
    self.textFrame = CGRectMake(textX, textY, textW, textH);
    
    CGFloat h = 0;
    // 3. 图片
    if (retweetedStatus.pic_urls.count) {
        CGFloat photoX = JDMarin10;
        CGFloat photoY = CGRectGetMaxY(self.textFrame) + JDMarin10;
        // 计算相册的尺寸
        CGSize photoSize = [JDPhotosView sizeWithPhotoCount:(int)retweetedStatus.pic_urls.count];
        CGFloat photoW = photoSize.width;
        CGFloat photoH = photoSize.height;
        self.photoFrame = CGRectMake(photoX, photoY, photoW, photoH);
        
        h = CGRectGetMaxY(self.photoFrame) + JDMarin10;
    }else{
        h = CGRectGetMaxY(self.textFrame) + JDMarin10;
    }
    
    
    // 设置自己的rect
    self.rect = CGRectMake(0, 0, JDScreenWidth, h);
}


@end
