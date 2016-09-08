//
//  JDCommentCell.h
//  丁丁说
//
//  Created by JiangDing on 15/12/9.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDCommentFrame;

@interface JDCommentCell : UITableViewCell

/**
 *  评论数据模型
 */
@property (nonatomic, strong) JDCommentFrame *commentFrame;

/**
 *  初始化Cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
