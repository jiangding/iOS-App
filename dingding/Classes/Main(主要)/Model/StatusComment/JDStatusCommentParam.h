//
//  JDStatusCommentParam.h
//  丁丁说
//
//  Created by JiangDing on 15/12/9.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDStatusCommentParam : NSObject

/** 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。 */
@property (nonatomic, copy) NSString *access_token;

/** max_id int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。  */
@property (nonatomic, strong) NSNumber *max_id;

/** since_id 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。*/
@property (nonatomic, strong) NSNumber  *since_id;

/** 单页返回的记录条数，最大不超过100，默认为20。 */
@property (nonatomic, strong) NSNumber *count;

/** int64	需要查询的微博ID。 */
@property (nonatomic, copy) NSString* id;

@end
