//
//  JDStatusReportResult.h
//  丁丁说
//
//  Created by JiangDing on 15/12/12.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDStatusReportResult : NSObject

/** 转发数组 */
@property (nonatomic, strong) NSArray *reposts;
/** 转发总数 */
@property (nonatomic, assign) int total_number;

@end
