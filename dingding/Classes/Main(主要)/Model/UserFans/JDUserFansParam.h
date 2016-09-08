//
//  JDUserFansParam.h
//  丁丁说
//
//  Created by JiangDing on 15/12/15.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDUserFansParam : NSObject
/** string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。 */
@property (nonatomic, copy) NSString *access_token;

/**	string	需要查询的用户昵称。 */
@property (nonatomic, copy) NSString *screen_name;

/** false	int	单页返回的记录条数，默认为50，最大不超过200。 */
@property (nonatomic, assign) int count;

/** int	返回结果的游标，下一页用返回值里的next_cursor，上一页用previous_cursor，默认为0。 */
@property (nonatomic, assign) int cursor;
 
@end
