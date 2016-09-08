//
//  JDCollectionViewCell.h
//  丁丁说
//
//  Created by JiangDing on 15/11/23.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;

// 是否是最后一张图片
@property (nonatomic, assign, getter=isLastImage) BOOL lastImage;

@end
