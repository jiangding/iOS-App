//
//  JDCommonCell.h
//  丁丁说
//
//  Created by JiangDing on 15/12/7.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDCommonItem;

@interface JDCommonCell : UITableViewCell

/**
 *  数据
 */
@property (nonatomic, strong) JDCommonItem *item;

/**
 *  初始化cell方法
 */
+(instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  设置每组的背景和选中背景
 */
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(NSInteger)rows;

@end
