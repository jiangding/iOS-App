//
//  JDUnReadCountParam.h
//  丁丁说
//
//  Created by JiangDing on 15/11/29.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDUnReadCountParam : NSObject
@property (nonatomic, strong) NSString *access_token;

/** 需要查询的用户id */
@property (nonatomic, strong) NSString *uid;
@end
