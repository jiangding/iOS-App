//
//  JDDiscoverController.m
//  丁丁说
//
//  Created by JiangDing on 15/11/21.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDDiscoverController.h"
#import "JDSearchBar.h"
#import "JDCommonGroup.h"
#import "JDCommonItem.h"
#import "JDCommonLabel.h"

@interface JDDiscoverController ()

@end

@implementation JDDiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
 
    // 添加搜索框
    JDSearchBar *searchBar = [JDSearchBar searchBar];
    searchBar.placeholder = @"大家都在搜:东北发现外星人";
    searchBar.width = self.view.width - 20;
    searchBar.height = 30;
    
    self.navigationItem.titleView = searchBar;
    
    
    
    // 添加组数据
    [self addGroups];
}

#pragma mark - 添加组数据

- (void)addGroups
{
    [self addGroup0];
    [self addGroup1];
    [self addGroup2];
}

- (void)addGroup0
{
    JDCommonGroup *group = [JDCommonGroup group];
    
    JDCommonItem *item0 = [JDCommonItem itemWithTitle:@"热门微博" icon:@"hot_status"];
    JDCommonItem *item1 = [JDCommonItem itemWithTitle:@"找人" icon:@"find_people"];
    item1.subTitle = @"名人,有意思的人都在这里";
    
    group.items = @[item0, item1];
    
    // 添加
    [self.groups addObject:group];
}

- (void)addGroup1
{
    JDCommonGroup *group = [JDCommonGroup group];
 
    // 2.设置组的所有行数据
    JDCommonItem *gameCenter = [JDCommonItem itemWithTitle:@"游戏中心" icon:@"game_center"];
 
    JDCommonItem *near = [JDCommonItem itemWithTitle:@"周边" icon:@"near"];
 
    JDCommonItem *app = [JDCommonItem itemWithTitle:@"应用" icon:@"app"];
    app.badgeValue = @"10";
    
    group.items = @[gameCenter, near, app];
 
    
    // 添加
    [self.groups addObject:group];
}

- (void)addGroup2
{
    JDCommonGroup *group = [JDCommonGroup group];
    
    // 2.设置组的所有行数据
    JDCommonItem *video = [JDCommonItem itemWithTitle:@"视频" icon:@"video"];
 
    JDCommonItem *music = [JDCommonItem itemWithTitle:@"音乐" icon:@"music"];
    JDCommonItem *movie = [JDCommonItem itemWithTitle:@"电影" icon:@"movie"];
 
    JDCommonLabel *cast = [JDCommonLabel itemWithTitle:@"播客" icon:@"cast"];
    cast.badgeValue = @"5";
    cast.subTitle = @"(10)";
    cast.text = @"axxxx";
    JDCommonItem *more = [JDCommonItem itemWithTitle:@"更多" icon:@"more"];
    
    group.items = @[video, music, movie, cast, more];
    
    // 添加
    [self.groups addObject:group];
}

@end
