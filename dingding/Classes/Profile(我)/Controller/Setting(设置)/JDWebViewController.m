//
//  JDPrifileDestController.m
//  丁丁说
//
//  Created by JiangDing on 15/12/7.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import "JDWebViewController.h"
#import "JDWebViewProgress.h"

@interface JDWebViewController () <WebViewProgressDelegate>

@property (nonatomic, strong) JDWebViewProgress *webProgress;

@property (nonatomic, weak) UIProgressView *progressView;
@end

@implementation JDWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webProgress = [[JDWebViewProgress alloc] init];
    self.webProgress.progressDelegate = self;
    
    // 1. 添加webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self.webProgress;
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:@"http://www.sina.com"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];

    // 2. 添加一个UIProgressView
    UIProgressView *progressView = [[UIProgressView alloc] init];
    progressView.y = 64;
    progressView.width = JDScreenWidth;
    progressView.height = 2;
    [self.view addSubview:progressView];
    self.progressView = progressView;
 
    
    UIActivityIndicatorView *acv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [acv startAnimating];
    [self.view addSubview:acv];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(JDWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    if (progress == 0.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            _progressView.progress = 0;
        [UIView animateWithDuration:0.25 animations:^{
            _progressView.alpha = 1.0;
        }];
    }
    if (progress == 1.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [UIView animateWithDuration:0.25 delay:progress - _progressView.progress options:0 animations:^{
            _progressView.alpha = 0.0;
        } completion:nil];
    }
    
    [_progressView setProgress:progress animated:YES];
}

@end
