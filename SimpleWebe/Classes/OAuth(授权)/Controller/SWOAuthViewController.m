//
//  SWOAuthViewController.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/9.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWOAuthViewController.h"
#import "SWAccountTool.h"
#import "SWHttpTool.h"
#import "SWControllerTool.h"

@interface SWOAuthViewController ()<UIWebViewDelegate, MBProgressHUDDelegate>

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation SWOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    
}

#pragma mark - UIWebViewDelegate
#pragma mark - UIWebViewDelegate
/**
 *  UIWebView开始加载资源的时候调用(开始发送请求)
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
    self.hud.delegate = self;
    self.hud.labelText = @"正在加载";
    
    [self.hud show:YES];
}

/**
 *  UIWebView加载完毕的时候调用(请求完毕)
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.hud hide:YES];
}

/**
 *  UIWebView加载失败的时候调用(请求失败)
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.hud hide:YES];
}

/**
 *  UIWebView每当发送一个请求之前,都会调用这个代理方法
 *
 
 *  @param request        即将发送的请求
 
 *
 *  @return YES:允许加载  NO:禁止加载
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    //    SWLog(@"%@", request.URL.absoluteString);
    NSString *url = request.URL.absoluteString;
    
    //判断url是否为回调地址
    
    NSString *str = [NSString stringWithFormat:@"%@/?code=",SWRedirectURI];
    NSRange range = [url rangeOfString:str];
    if (range.location != NSNotFound) { // 是回调地址
        //    if (range.length != 0)
        
        // 截取授权成功后的请求标记
        int from = (int)(range.location + range.length);
        NSString *code = [url substringFromIndex:from];

        // 根据code获得一个accessToken
        [self accessTokenWithCode:code];
        
        // 禁止加载回调页面
        return NO;
    }
    
    return YES;
}

/**
 *  根据code获得一个accessToken(发送一个POST请求)
 *
 *  @param code 授权成功后的请求标记
 */
- (void)accessTokenWithCode:(NSString *)code
{
    SWAccessTokenParam *param = [[SWAccessTokenParam alloc] init];
    param.client_id = SWAppkey;
    param.client_secret = SWAppSecret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = SWRedirectURI;
    
    
    [SWAccountTool accessTokenWithParam:param success:^(SWAccount *account) {
        //存储模型
        //确定账号的过期时间
        NSDate *nowTime = [NSDate date];
        account.expires_time = [nowTime dateByAddingTimeInterval:account.expires_in.doubleValue];
        [SWAccountTool save:account];
        // 切换控制器
        [SWControllerTool chooseRootViewController];

    } failure:^(NSError *error) {
        SWLog(@"请求失败--%@", error);
    }];
}
@end
