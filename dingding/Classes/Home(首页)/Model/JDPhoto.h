//
//  JDPhoto.h
//  丁丁说
//
//  Created by JiangDing on 15/11/24.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDPhoto : NSObject

/** 缩略图 */
@property (nonatomic, copy) NSString *thumbnail_pic;

/** 大点的缩略图 */
@property (nonatomic, copy) NSString *bmiddle_pic;
@end

