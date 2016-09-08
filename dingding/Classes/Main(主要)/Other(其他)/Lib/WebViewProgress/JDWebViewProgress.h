//
//  JDWebViewProgress.h
//  丁丁说
//
//  Created by JiangDing on 15/12/10.
//  Copyright © 2015年 JiangDing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JDWebViewProgress;


@protocol WebViewProgressDelegate <NSObject>
- (void)webViewProgress:(JDWebViewProgress *)webViewProgress updateProgress:(float)progress;
@end

@interface JDWebViewProgress : NSObject<UIWebViewDelegate>

@property (nonatomic, weak) id<WebViewProgressDelegate>progressDelegate;
@property (nonatomic, weak) id<UIWebViewDelegate>webViewProxyDelegate;
@property (nonatomic, copy) void (^progressBlock)(float progress) ;
@property (nonatomic, readonly) float progress; // 0.0..1.0
 
@end

