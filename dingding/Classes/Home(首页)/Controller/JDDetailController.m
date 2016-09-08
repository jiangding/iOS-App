//
//  JDDetailController.m
//  丁丁说
//
//  Created by JiangDing on 15/12/8.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDDetailController.h"
#import "JDDetailBottomToolBar.h"
#import "JDDetailView.h"
#import "JDDetaiFrame.h"
#import "JDStatus.h"
#import "JDDetailTableTopBar.h"
#import "JDStatusTool.h"
#import "JDStatusCommentParam.h"
#import "JDStatusCommentResult.h"
#import "JDStatusReportParam.h"
#import "JDStatusReportResult.h"
#import "JDAccount.h"
#import "JDAccountTool.h"
#import "JDComment.h"
#import "JDCommentFrame.h"
#import "JDCommentCell.h"
#import "JDDetailTableCover.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

@interface JDDetailController () <UITableViewDataSource, UITableViewDelegate, JDDetailTableTopBarDelegate>

// 表格控件
@property (nonatomic, weak) UITableView *tableView;

/** 表格顶部的view */
@property (nonatomic, strong) JDDetailTableTopBar *tableTopBar;

// 评论数据
@property (nonatomic, strong) NSMutableArray *comments;
// 转发数据
@property (nonatomic, strong) NSMutableArray *reposts;
// 赞的数据
@property (nonatomic, strong) NSArray *zans;



@property (nonatomic, strong) JDDetailTableCover *tableCover;

@end

@implementation JDDetailController

/**
 *  懒加载
 */
- (JDDetailTableTopBar *)tableTopBar
{
    if (_tableTopBar == nil) {
        _tableTopBar = [JDDetailTableTopBar toolBar];
        _tableTopBar.width = JDScreenWidth;
        _tableTopBar.height = 44;
        // 设置代理方法
        _tableTopBar.delegate = self;
        // 设置数据
        _tableTopBar.status = self.status;
    }
    return _tableTopBar;
}
- (UIView *)tableCover
{
    if (_tableCover == nil) {
        _tableCover = [[JDDetailTableCover alloc] init];
      
    }
    return _tableCover;
}

- (NSMutableArray *)comments
{
    if (_comments == nil) {
        self.comments = [NSMutableArray array];
    }
    return _comments;
}

- (NSMutableArray *)reposts
{
    if (_reposts == nil) {
        self.reposts = [NSMutableArray array];
    }
    return _reposts;
}

- (NSArray *)zans
{
    if (_zans == nil) {
        self.zans = [NSMutableArray array];
    }
    return _zans;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"微博正文";
 
    // 1. 添加tabView
    [self addTableView];
    
    // 2. 添加头部detailView
    [self addDetailView];
 
    // 3. 添加底部工具条
    [self addBottomToolBar];
 
}

/**
 *  添加detailView
 */
- (void)addDetailView
{
    // 1. 创建detailView
    JDDetailView *detailView = [[JDDetailView alloc] init];
 
    // 2. 创建detailFrame
    JDDetaiFrame *detailFrame = [[JDDetaiFrame alloc] init];
    detailFrame.status = self.status;
 
    // 3. 设置Frame
    detailView.detaiFrame = detailFrame;
 
    // 4. 设置表格的头部view
    self.tableView.tableHeaderView = detailView;
}

/**
 *  添加tabView
 */
- (void)addTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.x = 0;
    tableView.y = 0;
    tableView.width = self.view.width;
    tableView.height = self.view.height - 35;
    tableView.backgroundColor = JDGlobColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
  
    [self.view addSubview:tableView];
    self.tableView = tableView;

//        // 添加上拉添加
//        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            [self loadComments:YES];
//        }];
//        [footer setTitle:@"点击加载更多" forState:MJRefreshStateIdle];
//        [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
//        [footer setTitle:@"没数据" forState:MJRefreshStateNoMoreData];
//        // 设置字体
//        footer.stateLabel.font = [UIFont systemFontOfSize:13.0];
//        // 设置颜色
//        footer.stateLabel.textColor = [UIColor grayColor];
//        
//        self.tableView.mj_footer = footer;

}

/**
 *  添加底部工具条
 */
- (void)addBottomToolBar
{
    JDDetailBottomToolBar *bottomBar = [[JDDetailBottomToolBar alloc] init];
    bottomBar.width = JDScreenWidth;
    bottomBar.height = 42;
    bottomBar.y = self.view.height - bottomBar.height;
    bottomBar.x = 0;
    [self.view addSubview:bottomBar];
}

#pragma mark - tableView dataSourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 如果当前的是评论
    if (self.tableTopBar.selectedButtonType == JDTabTopBarTypeComment) {
        return self.comments.count;
    }else if(self.tableTopBar.selectedButtonType == JDTabTopBarTypeRetweeted){
        return self.reposts.count;
    }else if(self.tableTopBar.selectedButtonType == JDTabTopBarTypeZan){
        return self.zans.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    // 如果当前的是评论
    if (self.tableTopBar.selectedButtonType == JDTabTopBarTypeComment) {
        JDCommentCell *cell = [JDCommentCell cellWithTableView:tableView];
        
        JDCommentFrame *cmtF =  self.comments[indexPath.row];
        // 设置数据
        cell.commentFrame = cmtF;
        
        return cell;
    }else if(self.tableTopBar.selectedButtonType == JDTabTopBarTypeZan){
        static NSString *ID = @"retweetCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        
        // 设置数据
        NSDictionary *zan = self.zans[indexPath.row];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:zan[@"profile_image_url"]] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
        cell.textLabel.text = zan[@"name"];
        
         return cell;
    }
    return nil;
}

/**
 *  动态调整cell高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取模型
    if (self.tableTopBar.selectedButtonType == JDTabTopBarTypeComment) {
        JDCommentFrame *cmtF =  self.comments[indexPath.row];
        return cmtF.cellHeight;
    }else if(self.tableTopBar.selectedButtonType == JDTabTopBarTypeZan){
        return 60;
    }else{
        return 0;
    }
}

/**
 *  点击cell调用方法
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 弹出方法
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"回复" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }];
    UIAlertAction *ac2 = [UIAlertAction actionWithTitle:@"复制" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *ac3 = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *ac4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:ac1];
    [alertController addAction:ac2];
    [alertController addAction:ac3];
    [alertController addAction:ac4];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    // 取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:NO] ;
}


#pragma mark - UITableViewDelegate
/**
 *  设置table顶部的view, 必须设置高度,
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.tableTopBar;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.tableTopBar.height;
}

/**
 *  设置table尾部view,
 */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    // 如果当前的是评论
    if (self.tableTopBar.selectedButtonType == JDTabTopBarTypeComment && self.comments.count == 0) {
        if (![self.tableCover.text isEqualToString:@"数据查找失败"]) {
            self.tableCover.text = @"当前还没有评论";
        }
        return self.tableCover;
    }else if(self.tableTopBar.selectedButtonType == JDTabTopBarTypeRetweeted && self.reposts.count == 0){
 
        if (![self.tableCover.text isEqualToString:@"数据查找失败"]) {
            self.tableCover.text = @"当前还没有转发";
        }
 
        return self.tableCover;
    }else if(self.tableTopBar.selectedButtonType == JDTabTopBarTypeZan && self.zans.count == 0){
   
        if (![self.tableCover.text isEqualToString:@"数据查找失败"]) {
            self.tableCover.text = @"当前还没有人赞";
        }
 
        return self.tableCover;
    }else{
        return nil;
    }
 
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    // 如果当前的是评论
    if (self.tableTopBar.selectedButtonType == JDTabTopBarTypeComment && self.comments.count == 0) {
        return 120;
    }else if(self.tableTopBar.selectedButtonType == JDTabTopBarTypeRetweeted && self.reposts.count == 0){
        return 120;
    }else if(self.tableTopBar.selectedButtonType == JDTabTopBarTypeZan && self.zans.count == 0){
        return 120;
    }else{
        return 0;
    }
}


#pragma mark - JDDetailTableTopBarDelegate
- (void)tableTopBar:(JDDetailTableTopBar *)tableTopBar DidSelectedBtn:(JDTabTopBarType)topBarType
{
    switch (topBarType) {
        case JDTabTopBarTypeRetweeted:
            // 请求转发的数据
            self.tableCover.text = nil;
            [self loadRetweeted];
            break;
        case JDTabTopBarTypeComment:
            self.tableCover.text = nil;
            // 请求评论数据
            [self loadComments:NO];
            break;
        case JDTabTopBarTypeZan:
            self.tableCover.text = nil;
            // 请求赞的数据
            [self loadZan];
            break;
    }
}

#pragma mark - 加载数据

/**
 *  加载赞的数据
 */
- (void)loadZan
{
    
    
    if(arc4random() % 2 && self.comments.count != 0){
        self.zans = @[
                @{@"name":@"今早上", @"profile_image_url" :@"http://tp1.sinaimg.cn/1568450860/50/5730569156/1"},
                @{@"name":@"明天先去", @"profile_image_url" : @"http://tp2.sinaimg.cn/2891529877/50/5714970948/1"},
        ];
    }
 
    [self.tableView reloadData];
}

/**
 *  加载转发
 */
- (void)loadRetweeted
{
#warning 新浪微博API没有提供转发列表的接口
    // 1. 参数
    JDStatusReportParam *param = [[JDStatusReportParam alloc] init];
    param.access_token = [JDAccountTool account].access_token;
    param.id = self.status.idstr;
 
    // 获取评论第一个
    JDStatus *status = [self.reposts firstObject];
    param.since_id = @([status.idstr longLongValue]);
 
    [JDStatusTool getSingleStatusReport:param success:^(JDStatusReportResult *result) {
        // 更新转发总数
        self.status.reposts_count = result.total_number;
        self.tableTopBar.type = JDTabTopBarTypeRetweeted;
        self.tableTopBar.status = self.status;
 
        // 添加评论数据到table
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.reposts.count)];
        [self.reposts insertObjects:result.reposts atIndexes:indexSet];

        // 重载数据
        [self.tableView reloadData];
        

 
    } failure:^(NSError *error) {
        self.tableTopBar.type = JDTabTopBarTypeRetweeted;
        self.tableCover.text = @"数据查找失败";
        JDLog(@"请求转发失败: %@", error);
 
    }];

}



/**
 *  加载评论
 */
- (void)loadComments:(BOOL)maxId
{
 
    // 1. 创建参数
    JDStatusCommentParam *param = [[JDStatusCommentParam alloc] init];
    param.access_token = [JDAccountTool account].access_token;
    param.id = self.status.idstr;

    if (maxId) {
        // 获取评论最后一个
        JDCommentFrame *cmtF = [self.comments lastObject];
        param.max_id = @([cmtF.comment.idstr longLongValue] - 1);
    }else{
        // 获取评论第一个
        JDCommentFrame *cmtF = [self.comments firstObject];
        param.since_id = @([cmtF.comment.idstr longLongValue]);
    }

    [JDStatusTool getSingleStatusComment:param success:^(JDStatusCommentResult *result) {
        
        // 更新评论总数
        self.status.comments_count = result.total_number;
        self.tableTopBar.type = JDTabTopBarTypeComment;
        self.tableTopBar.status = self.status;
        
        NSMutableArray *frameArr = [NSMutableArray array];
        // comment 转为frame
        for (JDComment *comment in result.comments) {
            JDCommentFrame *cf = [[JDCommentFrame alloc] init];
            cf.comment = comment;
            [frameArr addObject:cf];
        }
        if (maxId) {
            [self.comments addObjectsFromArray:self.comments];
        }else{
            // 添加评论数据到table
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, frameArr.count)];
            [self.comments insertObjects:frameArr atIndexes:indexSet];
        }
        // 重载数据
        [self.tableView reloadData];
        
        // 停止
        //[self.tableView.mj_footer endRefreshing];
 
    } failure:^(NSError *error) {
        JDLog(@"请求评论失败: %@", error);
        self.tableTopBar.type = JDTabTopBarTypeComment;
        self.tableCover.text = @"数据查找失败";
        // 停止
        //[self.tableView.mj_footer endRefreshing];
    }];
}

@end
