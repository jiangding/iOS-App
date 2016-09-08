//
//  JDFansController.m
//  丁丁说
//
//  Created by JiangDing on 15/12/11.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDFansController.h"
#import "JDStatusTool.h"
#import "JDUserFansParam.h"
#import "JDUserFansResult.h"
#import "JDAccountTool.h"
#import "JDAccount.h"
#import "JDUser.h"
#import "MJRefresh.h"
#import "JDFansCell.h"

@interface JDFansController ()

/** 粉丝数组 */
@property (nonatomic, strong) NSMutableArray *fanses;

@end

@implementation JDFansController

- (NSMutableArray *)fanses
{
    if (_fanses == nil) {
        _fanses = [NSMutableArray array];
    }
    return _fanses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"粉丝";
    self.tableView.backgroundColor = JDGlobColor;
    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 
    // 添加
    [self addRefrush];
 }

- (void)addRefrush
{
 
    // 下拉添加
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fanses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    // 1. 获取自定义cell
    JDFansCell *cell = [JDFansCell cellWithTableView:tableView];
    
    // 2. 设置数据
    cell.user = self.fanses[indexPath.row];
 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/**
 *  加载最新的数据
 */
- (void)loadNewData
{
    // 1. 参数
    JDUserFansParam *param = [[JDUserFansParam alloc] init];
    param.access_token = [JDAccountTool access_token];
    param.screen_name = [JDAccountTool account].name;
    param.count = 100;
    
    // 2. 发送请求
    [JDStatusTool getUserFansWithParam:param success:^(JDUserFansResult *result) {
        
        //param.cursor = result.next_cursor;
        
        [self.fanses addObjectsFromArray:result.users];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        JDLog(@"获取粉丝数据错误: %@", error);
        [self.tableView.mj_header endRefreshing];
    }];
 
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
