//
//  JDFansCell.h
//  丁丁说
//
//  Created by JiangDing on 15/12/15.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDUser;

@interface JDFansCell : UITableViewCell

@property (nonatomic, strong) JDUser *user;


/**
 *  初始化类方法
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
