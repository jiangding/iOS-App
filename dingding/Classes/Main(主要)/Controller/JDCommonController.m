//
//  JDCommonTableController.m
//  丁丁说
//
//  Created by JiangDing on 15/12/7.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDCommonController.h"
#import "JDCommonGroup.h"
#import "JDCommonItem.h"
#import "JDCommonCell.h"

@interface JDCommonController ()

@end

@implementation JDCommonController

/**
 *  懒加载
 */
- (NSArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}
/**
 *  设置tableView默认分组样式
 */
- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tablView属性
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = JDGlobColor;
    // 设置头尾间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = JDMarin10;
    // 设置顶部距离
    self.tableView.contentInset = UIEdgeInsetsMake(JDMarin10-35, 0, 0, 0);
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 计算哪一组
    JDCommonGroup *group = self.groups[section];
    // 返回某一组中的item个数
    return group.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 获取cell
    JDCommonCell *cell = [JDCommonCell cellWithTableView:tableView];
    
    // 设置数据
    // 计算哪一组
    JDCommonGroup *group = self.groups[indexPath.section];
    // 计算哪个item
    JDCommonItem *item = group.items[indexPath.row];
    // 设置数据
    cell.item = item;
 
    
    // 传递位置过去设置图片
    [cell setIndexPath:indexPath rowsInSection:group.items.count];
    
    return cell;
}
 
// 点击某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1. 获取某一组
    JDCommonGroup *group = self.groups[indexPath.section];
    
    // 2. 获取单个item
    JDCommonItem *item = group.items[indexPath.row];
    
    // 3. 判断有无要跳转到控制器
    if (item.destClass) {
        // 跳转
        UIViewController *destVC = [[item.destClass alloc] init];
        destVC.title = item.title;
        [self.navigationController pushViewController:destVC animated:YES];
    }
    
    // 4. 判断有无执行block
    if (item.block) {
        item.block();
    }

    // 5. 设置点击的cell立马不选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


// 头部信息
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    JDCommonGroup *group = self.groups[section];
    return group.headTitle;
}
// 尾部信息
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    JDCommonGroup *group = self.groups[section];
    return group.footTitle;
}

 @end
