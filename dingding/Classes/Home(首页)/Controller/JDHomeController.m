//
//  JDHomeController.m
//  丁丁说
//
//  Created by JiangDing on 15/11/20.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDHomeController.h"
#import "JDTitleButton.h"
#import "JDPopMenu.h"
#import "JDAccountTool.h"
#import "JDAccount.h"

#import "JDUser.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "JDHttpTool.h"

#import "JDHomeStatusResult.h"
#import "JDHomeStatusParam.h"
#import "JDUserInfoResult.h"
#import "JDUserInfoParam.h"
#import "JDStatusTool.h"
#import "JDUserTool.h"

#import "JDStatusFrame.h"
#import "JDStatus.h"
#import "MBProgressHUD+MJ.h"
#import "JDStatusCell.h"
#import "JDDetailController.h"
#import "JDCameraController.h"
#import "JDComposeController.h"
#import "JDNavigationController.h"
#import "JDTitleView.h"

@interface JDHomeController () <JDPopMenuDelegate>
@property (nonatomic, weak) JDPopMenu *popMenu;
@property (nonatomic, weak) JDTitleButton *titleBtn;

@property (nonatomic, assign) int idx;

/**
 *  微博数组, 存放微博数据
 */
@property (nonatomic, strong) NSMutableArray *statues;
@end

@implementation JDHomeController
/**
 *  懒加载
 */
- (NSMutableArray *)statues
{
    if (_statues == nil) {
        _statues = [NSMutableArray array];
    }
    return _statues;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置整个tableView 背景颜色
    self.tableView.backgroundColor = JDGlobColor;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    // 0. 获取用户信息
    [self setUserInfo];
    
    // 1. 设置顶部按钮
    [self setTopButton];
  
    // 2. 添加上下拉刷新
    [self addRefresh:kHomeStatusTypeDefault];
    
    // 3. 接收通知
    [self addNotification];
}
#pragma mark - 所有的通知方法
/**
 *  接收通知
 */
-(void)addNotification
{
    
    // 点击首页标题接受的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleDidClick:) name:JDHomeStatusTitleNotifcation object:nil];
    
    //点击@#http文字发出的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(linkDidClick:) name:JDLinkDidSelectedNotification object:nil];
    
    // 点击评论发出的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentClick:) name:JDStatusCommentClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentClickZero:) name:JDStatusCommentClickZeroNotification object:nil];
}

/**
 *  点击首页标题接受的通知方法
 */
- (void)titleDidClick:(NSNotification *)note
{
    NSDictionary *dict = note.userInfo[JDHomeStatusTitleInfo];
 
    // 获取tag
    int tag = (int)[dict[@"tag"] integerValue];
    
    NSString *text = dict[@"text"];
 
    switch (tag) {
        case JDHomeTitleTypeDefault:
            [self setTopButton];
            // 计算第一次不刷新
            if (self.idx) {
                [self addRefresh:kHomeStatusTypeDefault];
            }
            self.idx ++;

            break;
        case JDHomeTitleType1:
            [self.titleBtn setTitle:text forState:UIControlStateNormal];
            // 从新调用数据
            [self addRefresh:kHomeStatusTypeFriend];
            break;
        case JDHomeTitleType2:
            [self.titleBtn setTitle:text forState:UIControlStateNormal];
            // 从新调用数据
            [self addRefresh:kHomeStatusTypeMyStatus];
            break;
        default:
            JDLog(@"其他");
            break;
    }
    
    // 消失遮盖
    [self.popMenu dismiss];
}


/**
    评论数目为0事后调用的通知方法
 */
- (void)commentClickZero:(NSNotification *)note
{
    // 发评论
    JDComposeController *compose = [[JDComposeController alloc] init];
    compose.prefix = @"发评论";
    compose.holder = @"写评论...";
    compose.commentId = note.userInfo[@"comId"];
    JDNavigationController *nav = [[JDNavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}

/**
 *  点击评论按钮调用通知方法
 */
- (void)commentClick:(NSNotification *)note
{
    // 跳转链接
    JDDetailController *detailVc = [[JDDetailController alloc] init];
    // 设置数据过去
    detailVc.status = note.userInfo[@"status"];
    // 设置锚点
    detailVc.view.layer.anchorPoint = CGPointMake(0, 0.5);
    detailVc.view.layer.position = CGPointMake(100,100);
    
    [self.navigationController pushViewController:detailVc animated:YES];
}

/**
 *  点击@#http文字发出的通知调用方法
 */
- (void)linkDidClick:(NSNotification *)note
{
    NSString *linkText = note.userInfo[JDLinkText];

    // 判断前缀
    if ([linkText hasPrefix:@"http"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkText]];
    }else{
        JDLog(@"%@", linkText);
    }
}


/**
 *  获取用户信息
 */
- (void)setUserInfo
{
    // 1. 封装请求参数
    JDUserInfoParam *params = [[JDUserInfoParam alloc] init];
    params.access_token  = [JDAccountTool account].access_token;
    params.uid = [JDAccountTool account].uid;
    
    
    // 2. 发送请求
    [JDUserTool getUserInfoWithParam:params success:^(JDUserInfoResult *result) {
       
        // 及时设置用户名称
        [self.titleBtn setTitle:result.name forState:UIControlStateNormal];
        
        // 获取登陆信息
        JDAccount *account = [JDAccountTool account];
        // 赋值
        account.name = result.name;
        
        // 重新保存
        [JDAccountTool save:account];
        
    } failure:^(NSError *error) {
        JDLog(@"获取用户数据失败:%@",error);
    }];
 
}

/**
 *  刷新加载数据
 */
- (void)addRefresh:(kHomeStatusType)statusType;
{
    // 1. 下拉添加
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewStatus:statusType];
    }];
    [self.tableView.mj_header beginRefreshing];
    

    // 2. 上拉添加
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreStatus:statusType];
    }];
}


#pragma mark - 上拉数据
/**
 *  加载上拉更多数据
 *  
 *  @param kHomeStatusType 微博数据类型
 */
- (void)loadMoreStatus:(kHomeStatusType)statusType
{
 
    // 1. 封装参数
    JDHomeStatusParam *params = [[JDHomeStatusParam alloc] init];
    params.statusType = statusType;
    params.access_token = [JDAccountTool account].access_token;
    
    // 2. 获取最后的那条微博
    JDStatusFrame *lastStatusFrame = self.statues.lastObject;
    JDStatus *lastStatus = lastStatusFrame.status;
    if (lastStatus) {
        params.max_id = @([lastStatus.idstr longLongValue] - 1);
    }
    
    // 3. 发送请求
    [JDStatusTool getHomeStatusWithParam:params success:^(JDHomeStatusResult *result) {
        NSMutableArray *arrFrame = [NSMutableArray array];
        //  转换成statusFrame模型
        for (JDStatus *status in  result.statuses) {
            JDStatusFrame *statusFrame = [[JDStatusFrame alloc] init];
            statusFrame.status = status;
            [arrFrame addObject:statusFrame];
        }
        
        // 插入到数组的最后面
        [self.statues addObjectsFromArray:arrFrame];
        
        // 重载数据
        [self.tableView reloadData];
        
        // 停止
        [self.tableView.mj_footer endRefreshing];

    } failure:^(NSError *error) {
        JDLog(@"请求失败 %@", error);
        // 停止
        [self.tableView.mj_footer endRefreshing];
    }];
    
}


#pragma mark - 下拉数据
/**
 *  加载最新微博数据
 *
 *  @param kHomeStatusType 微博数据类型
 */
- (void)loadNewStatus:(kHomeStatusType)statusType
{
    JDHomeStatusParam *params = [[JDHomeStatusParam alloc] init];
    params.statusType = statusType;
    params.access_token = [JDAccountTool account].access_token;

    // 2. 获取最新的那一条微博
    JDStatusFrame *firstStatusFrame = [self.statues firstObject];
    JDStatus *firstStatus = firstStatusFrame.status;
    if (firstStatus) {
        params.since_id = @([firstStatus.idstr longLongValue]);
    }
    
    // 3. 发送请求
    [JDStatusTool getHomeStatusWithParam:params success:^(JDHomeStatusResult *result) {
        
        NSMutableArray *arrFrame = [NSMutableArray array];
        //  转换成statusFrame模型
        for (JDStatus *status in  result.statuses) {
            JDStatusFrame *statusFrame = [[JDStatusFrame alloc] init];
            statusFrame.status = status;
            [arrFrame addObject:statusFrame];
        }
 
        NSRange range = NSMakeRange(0, arrFrame.count);
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        
        // 把一个数组插入到另一个数组中, 指定索引
        [self.statues insertObjects:arrFrame atIndexes:indexSet];
        
        // 重新刷新表格
        [self.tableView reloadData];
        
        // 停止下拉
        [self.tableView.mj_header endRefreshing];
        
        // 显示本次更新了多少条微博
        [self showUpdateStatus:arrFrame.count];
 
    } failure:^(NSError *error) {
        JDLog(@"失败! %@", error);
        [MBProgressHUD showError:@"数据加载失败!"];
        
        // 停止下拉
        [self.tableView.mj_header endRefreshing];
    }];
 
}

/**
 *  设置更新微博提示
 */
- (void)showUpdateStatus:(NSInteger)count
{
    UILabel *label = [[UILabel alloc] init];
    if (count) {
        label.text = [NSString stringWithFormat:@"本次更新%ld条微博", (long)count];
    }else{
        label.text = @"本次没有数据更新";
    }
    label.width = self.view.width;
    label.height = 30;
    label.x = 0;
    label.y = 34;
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13.0];
    label.alpha = 0.0;
    [self.navigationController.view insertSubview:label atIndex:1];
    
    // 动画变化
    [UIView animateWithDuration:0.75 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
        label.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.5 animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}



#pragma mark - 设置顶部按钮
/**
 *  设置顶部按钮
 */
- (void)setTopButton
{
    // 设置导航栏按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithIcon:@"navigationbar_friendsearch" hightIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendSearch)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithIcon:@"navigationbar_pop" hightIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    
    // 设置title按钮
    JDTitleButton *titleBtn = [[JDTitleButton alloc] init];
    // 设置文字
    NSString *username = [JDAccountTool account].name;
    [titleBtn setTitle: username ? username : @"首页" forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
    self.titleBtn = titleBtn;
}

- (void)friendSearch
{
    
}
- (void)pop
{
    JDCameraController *camera = [[JDCameraController alloc] init];
//    JDNavigationController *nav = [[JDNavigationController alloc] initWithRootViewController:camera];
//    [self presentViewController:nav animated:YES completion:nil];
    [self.navigationController pushViewController:camera animated:YES];
}

/**
 * 点击title按钮方法
 */
- (void)titleClick:(JDTitleButton *)titleBtn
{
    // 设置图片改变
    titleBtn.selected = NO;
  
#warning 如果当前pop存在就不在创建, 提高性能
    if (self.popMenu) {
        self.popMenu.alpha = 1.0;
    }else{
        JDTitleView *titleView = [[JDTitleView alloc] init];
        JDPopMenu *popMenu = [JDPopMenu popWithContentView:titleView];
        self.popMenu = popMenu;
        //popMenu.iconType = JDPopMenuIconArrowMid;
        //popMenu.isBackground = NO;
        popMenu.delegate = self;
        CGFloat popW = 180;
        CGFloat popH = 250;
        CGFloat popX = (JDScreenWidth - popW) * 0.5;
        CGFloat popY = 54;
        [popMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    }
}

#pragma mark  JDPopMenuDelegate
- (void)popMenuDidClickCover:(JDPopMenu *)popMenu
{
    self.titleBtn.selected = YES;
}

#pragma mark - table Datasourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statues.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1. 获取自定义cell
    JDStatusCell *cell = [JDStatusCell cellWithTableView:tableView];
  
    // 2. 赋值模型数据
    cell.statusFrame = self.statues[indexPath.row];
 
    return cell;
}

// cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDStatusFrame *statusFrame = self.statues[indexPath.row];
    
    return statusFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 1. 获取当前statusFrame
    JDStatusFrame *statusFrame = self.statues[indexPath.row];
    
    // 2. 获取数据
    JDStatus *status = statusFrame.status;
    
    // 跳转链接
    JDDetailController *detailVc = [[JDDetailController alloc] init];
    // 3. 设置数据过去
    detailVc.status = status;
    [self.navigationController pushViewController:detailVc animated:YES];
    
    // 4. 取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


/**
 *  清除所有通知
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
