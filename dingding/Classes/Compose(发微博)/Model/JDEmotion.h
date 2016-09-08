//
//  JDEmotion.h
//  丁丁说
//
//  Created by JiangDing on 15/12/3.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDEmotion : NSObject <NSCoding>

/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的文png图片名 */
@property (nonatomic, copy) NSString *png;
/** emoji表情的编码 */
@property (nonatomic, copy) NSString *code;

/** emoji表情的字符 */
@property (nonatomic, copy) NSString *emoji;

// 目录
@property (nonatomic, copy) NSString *founder;

@end
