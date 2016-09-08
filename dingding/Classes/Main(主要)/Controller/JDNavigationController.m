//
//  JDNavigationController.m
//  丁丁说
//
//  Created by JiangDing on 15/11/21.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDNavigationController.h"
#import "JDTabBarController.h"
#import "JDNavigationBar.h"

@interface JDNavigationController () <UINavigationControllerDelegate>

@end

@implementation JDNavigationController

/**
 *  类方法, 只调用一次
 */
+(void)initialize
{
    // 获取外观 , 当前所有的barButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    // 设置正常文字状态
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttr[NSFontAttributeName] = [UIFont systemFontOfSize:16.0];
    [appearance setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    
    // 设置高亮文字状态
    NSMutableDictionary *textHighAttr = [NSMutableDictionary dictionary];
    textHighAttr[NSForegroundColorAttributeName] = [UIColor redColor];
    [appearance setTitleTextAttributes:textHighAttr forState:UIControlStateHighlighted];
    
    // 设置不可用文字状态
    NSMutableDictionary *textDisabledAttr = [NSMutableDictionary dictionary];
    textDisabledAttr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [appearance setTitleTextAttributes:textDisabledAttr forState:UIControlStateDisabled];
    
    /**设置背景**/
    // 技巧: 为了让某个按钮的背景消失, 可以设置一张完全透明的背景图片
    [appearance setBackgroundImage:[UIImage strectchImageWithNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    // 获取
    UINavigationBar *appear = [UINavigationBar appearance];
    NSMutableDictionary *navText = [NSMutableDictionary dictionary];
    navText[NSForegroundColorAttributeName] = [UIColor blackColor];
    navText[NSFontAttributeName] = JDTitleFont;
    [appear setTitleTextAttributes:navText];
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
#warning 解决push / pop 时候出现的黑底问题
    self.view.backgroundColor = [UIColor whiteColor];

    // KVC替换掉系统导航栏
    [self setValue:[[JDNavigationBar alloc] init] forKeyPath:@"navigationBar"];
}



/**
 *  所有push方法都会调用
 *
 *  @param viewController 目的控制器
 *  @param animated
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
 
    // 如果当前控制器不是栈顶控制器就隐藏底部导航栏
    if (self.viewControllers.count > 0) {
 
        // 隐藏
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置通用的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithIcon:@"navigationbar_back" hightIcon:@"navigationbar_back_highlighted" target:self action:@selector(leftBtnClick)];
 
        //viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithIcon:@"navigationbar_more" hightIcon:@"navigationbar_more_highlighted" target:self action:@selector(rightBtnClick)];
    
    }
    [super pushViewController:viewController animated:YES];
 
}
 
/**
 *  左边点击
 */
- (void)leftBtnClick
{
#warning 这里本来就应该用navigationController来执行这些方法
    // 返回上一层
    [self popViewControllerAnimated:YES];
  
}

/**
 *  右边点击
 */
- (void)rightBtnClick
{
    // 返回到顶部
    [self popToRootViewControllerAnimated:YES];
}

@end
