//
//  JDComposeController.h
//  丁丁说
//
//  Created by JiangDing on 15/11/23.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDComposeController : UIViewController

/** 前缀 */
@property (nonatomic, copy) NSString *prefix;

/** 占位符 */
@property (nonatomic, copy) NSString *holder;
/** 评论id */
@property (nonatomic, copy) NSString *commentId;

@end
