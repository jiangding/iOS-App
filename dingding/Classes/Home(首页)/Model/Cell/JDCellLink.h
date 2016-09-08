//
//  JDCellLink.h
//  丁丁说
//
//  Created by JiangDing on 15/12/5.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDCellLink : NSObject
/** 链接文字 */
@property (nonatomic, copy) NSString *text;
/** 链接的范围 */
@property (nonatomic, assign) NSRange range;
/** 链接的边框 */
@property (nonatomic, strong) NSArray *rects;

@end
