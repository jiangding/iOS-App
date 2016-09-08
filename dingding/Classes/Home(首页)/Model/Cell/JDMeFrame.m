//
//  JDMeFrame.m
//  丁丁说
//
//  Created by JiangDing on 15/11/29.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDMeFrame.h"
#import "JDStatus.h"
#import "JDUser.h"
#import "JDPhotosView.h"

@interface JDMeFrame ()


@end
@implementation JDMeFrame


- (void)setStatus:(JDStatus *)status
{
    _status = status;
    
    // 1. 头像
    CGFloat iconX = JDMarin10;
    CGFloat iconY = iconX;
    CGFloat iconW = 40;
    CGFloat iconH = iconW;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);

    // 2. 标题
    CGFloat titleX = CGRectGetMaxX(self.iconFrame) + JDMarin10;
    CGFloat titleY = iconY;
    CGSize titleSize = [status.user.name sizeWithAttributes:@{NSFontAttributeName : JDStatusNameFont}];
    CGFloat titleW = titleSize.width;
    CGFloat titleH = titleSize.height;
    self.titleFrame = CGRectMake(titleX, titleY, titleW, titleH);
    
    // 2.5 vip
    CGFloat vipX = CGRectGetMaxX(self.titleFrame) + JDMarin5;
    CGFloat vipY = titleY;
    CGFloat vipW = 16;
    CGFloat vipH = vipW;
    self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
 
    
    // 5. 正文
    CGFloat textX = JDMarin10;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + JDMarin10;
    CGSize maxSize = CGSizeMake(JDScreenWidth - 2 * textX, MAXFLOAT);
    CGRect textRect = [status.attrText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
 
    CGFloat textW = textRect.size.width;
    CGFloat textH = textRect.size.height;
    self.textFrame = CGRectMake(textX, textY, textW, textH);
    
    
    CGFloat h = 0;
    // 6. 图片墙
    if (status.pic_urls.count) {
        CGFloat photoX = JDMarin10;
        CGFloat photoY = CGRectGetMaxY(self.textFrame) + JDMarin10;
      
        // 获取相册的尺寸
        CGSize photoSize = [JDPhotosView sizeWithPhotoCount:(int)status.pic_urls.count];
        self.photoFrame = CGRectMake(photoX, photoY, photoSize.width - photoX, photoSize.height);
        
        h = CGRectGetMaxY(self.photoFrame) + JDMarin10;
        
    }else{
        h = CGRectGetMaxY(self.textFrame) + JDMarin10;
    }

    
    // 最后设置自身的frame
    self.rect = CGRectMake(0, 0, JDScreenWidth, h);
}

@end
