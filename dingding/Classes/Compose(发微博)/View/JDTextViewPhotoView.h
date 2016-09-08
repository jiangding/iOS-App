//
//  JDTextViewPhotoView.h
//  丁丁说
//
//  Created by JiangDing on 15/11/25.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDTextViewPhotoView : UIView

/**  图片  */
@property (nonatomic, strong) UIImage *image;

/** 提供当前所有图片 */
- (NSArray *)images;
@end
