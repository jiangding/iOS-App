//
//  JDProfileController.m
//  丁丁说
//
//  Created by JiangDing on 15/11/21.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDProfileController.h"
#import "JDSettingController.h"
#import "JDCommonItem.h"
#import "JDCommonGroup.h"
#import "JDCommonArrow.h"
#import "JDCommonLabel.h"
#import "JDCommonSwitch.h"
#import "NSString+File.h"
#import "MBProgressHUD+MJ.h"
#import "JDWebViewController.h"
#import "JDAccountTool.h"
#import "JDAccount.h"
#import "JDProfileTitleView.h"
#import "JDUserCenterController.h"
#import "JDFollowController.h"
#import "JDWeiboController.h"
#import "JDFansController.h"

@interface JDProfileController ()

@end

@implementation JDProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"我的";
 
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(settingClick)];
 
    JDProfileTitleView *titleView = [[JDProfileTitleView alloc] init];
    titleView.width = JDScreenWidth;
    titleView.height = 140;
    // 设置头视图
    self.tableView.tableHeaderView = titleView;
    // 表格顶部留空间
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
     // 初始化模型数据
    [self addGroups];

    // 接受通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WGFNote:) name:JDProfileNotificationWGF object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(personCenter) name:JDProfileNotificationPersonCenter object:nil];
}

// 点击去个人中心
- (void)personCenter
{
    JDUserCenterController *userCenter = [[JDUserCenterController alloc] init];
    [self.navigationController pushViewController:userCenter animated:YES];
}

// 微博, 关注, 粉丝的通知
- (void)WGFNote:(NSNotification *)note
{
    NSString *ne = note.userInfo[JDProfileWGF];

    UIViewController *vc = nil;
    
    if ([ne isEqualToString:@"微博"]) {
        vc = [[JDWeiboController alloc] init];
    }else if([ne isEqualToString:@"关注"]){
        vc = [[JDFollowController alloc] init];
    }else{
        vc = [[JDFansController alloc] init];
    }
    [self.navigationController pushViewController:vc animated:YES];
}


/**
 *  设置点击方法
 */
- (void)settingClick
{
    JDSettingController *settingVC = [[JDSettingController alloc] init];
    settingVC.title = @"设置";
    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark - 添加模型数据
/**
 *  添加模型数据
 */
- (void)addGroups
{
    [self addGroup0];
    [self addGroup1];
    [self addGroup2];
}


/**
 *  添加一组
 */
- (void)addGroup0
{
    
    JDCommonGroup *group = [JDCommonGroup group];

    JDCommonItem *item0 = [JDCommonArrow itemWithTitle:@"新的好友" icon:@"new_friend"];
    item0.badgeValue = @"2";
 
 
    JDCommonItem *item1 = [JDCommonArrow itemWithTitle:@"微博等级" icon:@"album"];
    item1.subTitle = @"升级,得奖励";
    
    JDCommonItem *item2 = [JDCommonArrow itemWithTitle:@"编辑资料" icon:@"car"];
    
    group.items = @[item0, item1,item2];
    
    [self.groups addObject:group];

}

/**
 *  添加第二组
 */
- (void)addGroup1
{
    JDCommonGroup *group = [JDCommonGroup group];
 
    JDCommonItem *item0 = [JDCommonArrow itemWithTitle:@"应用程序" icon:@"app"];
 
    JDCommonItem *item1 = [JDCommonArrow itemWithTitle:@"微博运动" icon:@"collect"];
 
    JDCommonItem *item2 = [JDCommonArrow itemWithTitle:@"多玩支付" icon:@"cast"];
    item2.subTitle = @"付款吧,孩子";
 
    // 设置
    group.items = @[item0, item1,item2];
    
    // 添加
    [self.groups addObject:group];
    
}

/**
 *  添加第三组
 */
- (void)addGroup2
{
    JDCommonGroup *group = [JDCommonGroup group];
    
    JDCommonItem *item0 = [JDCommonItem itemWithTitle:@"音乐" icon:@"music"];
    
    JDCommonArrow *item1 = [JDCommonArrow itemWithTitle:@"我的赞" icon:@"like"];
 
    JDCommonArrow *item2 = [JDCommonArrow itemWithTitle:@"更多" icon:@"more"];
    
    item2.subTitle = @"数据中心,收藏,等级";
    item2.destClass = [JDWebViewController class];
    // 设置
    group.items = @[item0,item1,item2];
    // 添加
    [self.groups addObject:group];
    
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
