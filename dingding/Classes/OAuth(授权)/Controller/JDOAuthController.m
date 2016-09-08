//
//  JDOAuthController.m
//  丁丁说
//
//  Created by JiangDing on 15/11/23.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDOAuthController.h"
#import "MBProgressHUD+MJ.h"

#import "JDControlTool.h"
#import "JDAccountTool.h"

#import "JDAccount.h"


#import "JDAccessTokenParam.h"

@interface JDOAuthController () <UIWebViewDelegate>

@end

@implementation JDOAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //1. 创建webView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
 
    [self.view addSubview:webView];
    
    //2. 加载登陆页面
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", AppKey, APPRedirectURI];
    NSURLRequest *request  = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [webView loadRequest:request];
    
    //3. 设置代理
    webView.delegate = self;
}

#pragma mark - UIWebViewDelegate

/**
 *  UIWebView开始加载资源的时候调用(开始发送请求)
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在记载中..."];
}

/**
 *  UIWebView开始加载资源的时候调用(发送请求结束)
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

/**
 *  UIWebView开始加载资源的时候调用(发送请求失败)
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

/**
 *  UIWebView开始加载资源的时候调用(每次调用一个请求都回执行这个代理方法, 此代理方法可以控制允不允许调用请求)
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
 
    // 1. 获取请求地址
    NSString *requestUrl = request.URL.absoluteString;
    
    //JDLog(@"%@", requestUrl);
    
    // 2. 根据请求的返回地址判断是不是回调
    //http:/ /www.baidu.com/?code=5f24b33f95aaf3098a81752e5bdd0bc4
   
    NSRange range = [requestUrl rangeOfString:[NSString stringWithFormat:@"%@/?code=", APPRedirectURI]];
    
    // 如果不是未找到. 就是存在 或者也可以用 range.length != 0
    if (range.location != NSNotFound) {
        
        // 截取后面一段code
        NSString *code = [requestUrl substringFromIndex:range.length];
        
        //JDLog(@"%@", code);
        
        // 根据code获取accessToken
        [self accessToken:code];
        
        // 禁止加载回调页面
        return NO;
    }
    
    
    return YES;
}

// 根据code获取accessToken
- (void)accessToken:(NSString *)code
{
 
    JDAccessTokenParam *param = [[JDAccessTokenParam alloc] init];
    param.client_id = AppKey;
    param.client_secret = AppSecret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = APPRedirectURI;
    
    [JDAccountTool postAccessTokenWithParam:param success:^(JDAccount *account) {
        //写入到文档
        [JDAccountTool save:account];
        
        // 跳转
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = [JDControlTool chooseRootViewController];
    } failure:^(NSError *error) {
        
        /**
         *  AFNetWork内部加上: unacceptable content-type: text/plain,
         */
        
        JDLog(@"请求失败 %@", error);
    }];
 
 }


/**
 
 请求成功! {
 "access_token" = "2.00aGfcCCyyJaZC6fc6d58529yKyngC";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 1871032812;
 }
 
 */

@end
