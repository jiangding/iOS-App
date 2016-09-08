//
//  JDCommentFrame.m
//  丁丁说
//
//  Created by JiangDing on 15/12/10.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDCommentFrame.h"
#import "JDComment.h"
#import "JDUser.h"
#import "NSDate+JD.h"
 
@implementation JDCommentFrame


- (void)setComment:(JDComment *)comment
{
    _comment = comment;
    
    // 1.头像
    CGFloat iconX = JDMarin10;
    CGFloat iconY = JDMarin10;
    CGFloat iconW = 35;
    CGFloat iconH = iconW;
    self.iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    
    // 2.姓名
    CGFloat titleX = CGRectGetMaxX(self.iconF) + JDMarin10;
    CGFloat titleY = iconY;
    // 计算文字的尺寸
    CGSize titleSize = [comment.user.name sizeWithAttributes:@{NSFontAttributeName : JDCommentTitleFont}];
    self.titleF = CGRectMake(titleX, titleY, titleSize.width, titleSize.height);
    
    // 2.5 vip
    CGFloat vipX = CGRectGetMaxX(self.titleF) + JDMarin10;
    CGFloat vipY = titleY;
    CGFloat vipW = 16;
    CGFloat vipH = vipW;
    self.vipF = CGRectMake(vipX, vipY, vipW, vipH);
    
    // 3. 时间
    CGFloat timeX = titleX;
    CGFloat timeY = CGRectGetMaxY(self.titleF) + JDMarin5;
    //计算尺寸
    CGSize timeSize = [[NSDate dateFormat:comment.created_at] sizeWithAttributes:@{NSFontAttributeName : JDCommentTimeFont}];
    self.timeF = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    // 4.
    CGFloat zanH = 18;
    CGFloat zanW = zanH;
    CGFloat zanX = JDScreenWidth - zanW - JDMarin10;
    CGFloat zanY = titleY;
    self.zanF = CGRectMake(zanX, zanY, zanY, zanH);
 
    // 5.
    CGFloat textX = timeX;
    CGFloat textY = CGRectGetMaxY(self.timeF) + JDMarin5;
    
    CGSize maxSize = CGSizeMake(JDScreenWidth - 2 *JDMarin10 - textX, MAXFLOAT);
    CGRect textRect = [comment.attrText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    self.textF = CGRectMake(textX, textY, textRect.size.width, textRect.size.height);
 
    
    // 设置行高
    self.cellHeight = CGRectGetMaxY(self.textF) + JDMarin10;
}

@end
