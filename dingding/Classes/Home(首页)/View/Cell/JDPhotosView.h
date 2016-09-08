//
//  JDPhotosView.h
//  丁丁说
//
//  Created by JiangDing on 15/11/30.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDPhotosView : UIView

/* *  图片数据,里面都是HMPhoto模型 */
@property (nonatomic, strong) NSArray *photos;

/** 根据图片的个数计算相册的尺寸 */
+ (CGSize)sizeWithPhotoCount:(int)photoCount;

@end
