//
//  JDStatusCell.h
//  丁丁说
//
//  Created by JiangDing on 15/11/29.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDStatusFrame;

@interface JDStatusCell : UITableViewCell

// 模型数据
@property (nonatomic, strong) JDStatusFrame *statusFrame;

/**
 *  初始化Cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
