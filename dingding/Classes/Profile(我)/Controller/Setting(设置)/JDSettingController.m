//
//  JDSettingController.m
//  丁丁说
//
//  Created by JiangDing on 15/12/7.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDSettingController.h"
#import "JDCommonGroup.h"
#import "JDCommonArrow.h"
#import "JDCommonLabel.h"
#import "NSString+File.h"
#import "MBProgressHUD+MJ.h"

@interface JDSettingController ()

@end

@implementation JDSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 添加组数据
    [self addGroups];
    
    // 添加退出按钮
    [self addLogout];
}

- (void)addLogout
{
    // 1.创建按钮
    UIButton *logout = [[UIButton alloc] init];
    
    // 2.设置属性
    logout.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [logout setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    [logout setTitleColor:JDColor(255, 10, 10) forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage strectchImageWithNamed:@"common_card_background"] forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage strectchImageWithNamed:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
    
    // 3.设置尺寸(tableFooterView和tableHeaderView的宽度跟tableView的宽度一样)
    logout.height = 44;
    
    self.tableView.tableFooterView = logout;
}

/**
 *  添加组
 */
- (void)addGroups
{
    [self addGroup0];
    [self addGroup1];
    [self addGroup2];
}

/**
 *  添加第一组
 */
- (void)addGroup0
{
    JDCommonGroup *group = [JDCommonGroup group];
    group.headTitle = @"账号";
    JDCommonArrow *item0 = [JDCommonArrow itemWithTitle:@"账号管理"];
    
    // 设置
    group.items = @[item0];
    
    // 添加
    [self.groups addObject:group];
}

/**
 *  添加第二组
 */
- (void)addGroup1
{
    JDCommonGroup *group = [JDCommonGroup group];
    
    JDCommonArrow *item0 = [JDCommonArrow itemWithTitle:@"通知"];
    JDCommonArrow *item1 = [JDCommonArrow itemWithTitle:@"隐私和安全"];
    JDCommonArrow *item2 = [JDCommonArrow itemWithTitle:@"通用设置"];
    // 设置
    group.items = @[item0,item1,item2];
    
    // 添加
    [self.groups addObject:group];
}

/**
 *  添加第三组
 */
- (void)addGroup2
{
    JDCommonGroup *group = [JDCommonGroup group];
    
    JDCommonLabel *clearCache = [JDCommonLabel itemWithTitle:@"清理缓存图片"];
    
    // 缓存文件路径
    NSString *cacheDoc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *imageCachePath = [cacheDoc stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    
    // 计算文件大小
    long long fileSize = [imageCachePath fileSize];
    
    clearCache.text = [NSString stringWithFormat:@"%.1fM", fileSize / (1000.0 * 1000.0)];
    
    __block typeof(self) weakSelf = self;
    __block typeof(clearCache) weakClearCache = clearCache;
    clearCache.block = ^(){
        // 弹出框
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {

            [MBProgressHUD showMessage:@"正在删除缓存中..."];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 清除缓存
                NSFileManager *mgr = [NSFileManager defaultManager];
                [mgr removeItemAtPath:imageCachePath error:nil];
                
                // 设置subtitle
                weakClearCache.text = nil;
                
                [MBProgressHUD hideHUD];
                
                // 刷新表格
                [weakSelf.tableView reloadData];
            });
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        }];
        
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        
        [weakSelf presentViewController:alertController animated:YES completion:nil];
 
    };

    
    JDCommonArrow *item1 = [JDCommonArrow itemWithTitle:@"意见反馈"];
    JDCommonArrow *item2 = [JDCommonArrow itemWithTitle:@"关于微博"];
    // 设置
    group.items = @[clearCache,item1,item2];
    
    // 添加
    [self.groups addObject:group];
}

@end
