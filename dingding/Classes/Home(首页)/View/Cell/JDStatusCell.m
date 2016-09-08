//
//  JDStatusCell.m
//  丁丁说
//
//  Created by JiangDing on 15/11/29.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDStatusCell.h"
#import "JDStatusFrame.h"
#import "JDDetaiFrame.h"

#import "JDDetailView.h"
#import "JDTabBarView.h"
 

@interface JDStatusCell()

@property (nonatomic, weak) JDDetailView *detaiView;

@property (nonatomic, weak) JDTabBarView *tabBarView;

@end

@implementation JDStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"homeCell";
    
    JDStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[JDStatusCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // 整个Cell现分为2部分
        // 1. 添加上面detaiView
        JDDetailView *detaiView = [[JDDetailView alloc] init];
        [self.contentView addSubview:detaiView];
        self.detaiView = detaiView;
        
        // 2. 添加下面tabView
        JDTabBarView *tabBarView = [[JDTabBarView alloc] init];
        [self.contentView addSubview:tabBarView];
        self.tabBarView = tabBarView;
        
        // 设置cell背景颜色
        self.backgroundColor = [UIColor clearColor];
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:JDColor(250, 250, 250)]];
    }
    return self;
}



// 设置数据
- (void)setStatusFrame:(JDStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
 
    //1. 设置detaiView frame
    self.detaiView.detaiFrame = statusFrame.detailFrame;
    
    //2. 底部frame
    self.tabBarView.frame = statusFrame.tabBarFrame;
    self.tabBarView.status = statusFrame.status;
 
}
@end
