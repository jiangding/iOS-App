//
//  JDMentionController.m
//  丁丁说
//
//  Created by JiangDing on 15/12/15.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDMentionController.h"
#import "MJExtension.h"
#import "JDCar.h"
#import "JDCarGroup.h"

@interface JDMentionController () <UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UISearchDisplayController *searchDisplayController;

/** 汽车组数组 */
@property (nonatomic, strong) NSArray *carGroups;

@property (nonatomic, strong) NSMutableArray *searchResults;


@end

@implementation JDMentionController

- (NSArray *)carGroups
{
    if (_carGroups == nil) {
        NSString *file = [[NSBundle mainBundle] pathForResource:@"cars_total.plist" ofType:nil];
        _carGroups = [JDCarGroup mj_objectArrayWithFile:file];
    }
    return _carGroups;
}



- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"联系人";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
    // 设置右边索引样式
    self.tableView.sectionIndexColor = [UIColor orangeColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];

 
    // 搜索
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, JDScreenWidth, 40)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索联系人";
    _searchBar.backgroundImage = [UIImage imageWithColor:JDGlobColor];
    
    
    // 搜索绑定的controller
    _searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
      _searchDisplayController.active = NO;
    _searchDisplayController.searchResultsDataSource = self;
    _searchDisplayController.searchResultsDelegate = self;
    _searchDisplayController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _searchDisplayController.searchResultsTitle = @"";
    // 设置tableView头部view
    self.tableView.tableHeaderView = self.searchBar;
 
}

/**
 *  关闭
 */
- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 数据源
// 有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView  && self.searchResults != nil) {
        return 1;
    }else {
        return self.carGroups.count;
    }
}

// 每组有多少个单元格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView && self.searchResults != nil) {
        return self.searchResults.count;
    }else{
        JDCarGroup *carGroup = self.carGroups[section];
        return carGroup.cars.count;
    }
}

// 每个单元格设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 标识符
    static NSString * ID = @"metionCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
 
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    JDCar *car = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView && self.searchResults != nil) {
        car = self.searchResults[indexPath.row];
    }else{
        JDCarGroup *carGroup = self.carGroups[indexPath.section];
        car = carGroup.cars[indexPath.row];
    }
 
    cell.textLabel.text = car.name;
    
    cell.imageView.image = [UIImage imageNamed:car.icon];
    cell.imageView.layer.cornerRadius = 20;
    cell.imageView.clipsToBounds = YES;
    
    
    // 设置cell背景颜色
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:JDColor(240, 240, 240)]];
    
    return cell;
    
}

// 每组的头部文字
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView && self.searchResults != nil) {
        return [NSString stringWithFormat:@"%ld条搜索结果", self.searchResults.count];
    }else{
        JDCarGroup *carGroup = self.carGroups[section];
        return carGroup.title;
    }
}

/**
 *  设置 tableView 右边的索引列表
 */
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    }else{
        return [self.carGroups valueForKey:@"title"];
    }
}


// 选中了某一个
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JDCar *car = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        car = self.searchResults[indexPath.row];
    }else{
        // 获取所选行的值
        JDCarGroup *carGroup = self.carGroups[indexPath.section];
        car = carGroup.cars[indexPath.row];
    }
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:JDMentionNotification object:self userInfo:@{JDMentionInfo : car.name}];
    
    // 关闭本页
    [self dismissViewControllerAnimated:YES completion:nil];
    // 取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma UISearchDisplayDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.searchResults = [[NSMutableArray alloc]init];
    if (self.searchBar.text.length > 0) {
        for (int i = 0; i < self.carGroups.count; i++) {
            JDCarGroup *carGroup = self.carGroups[i];
            for (JDCar *car in carGroup.cars) {
                NSRange titleResult=[car.name rangeOfString:self.searchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [self.searchResults addObject:car];
                }
            }
            
        }
    }
}

@end
