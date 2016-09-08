//
//  JDCarGroup.h
//  丁丁说
//
//  Created by JiangDing on 15/12/15.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDCarGroup : NSObject

/** 数组, 里面装car模型 */
@property (nonatomic, strong) NSArray *cars;

/** 组标题 */
@property (nonatomic, copy) NSString *title;
@end
