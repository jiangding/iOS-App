//
//  JDMssageController.m
//  丁丁说
//
//  Created by JiangDing on 15/11/21.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDMessageController.h"
#import "JDSearchBar.h"

@interface JDMessageController ()

@end

@implementation JDMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = JDRandomColor;
    
    self.title = @"消息";
    
    JDSearchBar *search = [JDSearchBar searchBar];
    search.width = 100;
    search.height = 30;
    search.x = 100;
    search.y = 100;
    
    [self.view addSubview:search];
    
}


#pragma mark table Datasourse


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"messageCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = @"消息控制器";
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    vc.title = @"消息title";
    [self.navigationController pushViewController:vc animated:YES];
}


@end
