//
//  JDCommonGroup.h
//  丁丁说
//
//  Created by JiangDing on 15/12/7.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDCommonGroup : NSObject

/** 组,内装JDCommonItem */
@property (nonatomic, strong) NSArray *items;

/** 头部标题 */
@property (nonatomic, copy) NSString *headTitle;
/** 尾部标题 */
@property (nonatomic, copy) NSString *footTitle;

/**
  初始化类方法
 */
+ (instancetype)group;
@end
