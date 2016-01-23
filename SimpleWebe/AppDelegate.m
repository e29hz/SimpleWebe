//
//  AppDelegate.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/6.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "AppDelegate.h"
#import "SWTabBarViewController.h"
#import "SWOAuthViewController.h"
#import "SWAccountTool.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "SWHttpTool.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    //2.显示窗口（成为主窗口）
    [self.window makeKeyAndVisible];

    SWAccount *account = [SWAccountTool account];
    
    //3.设置窗口的根控制器
    
    if (account) {
    
        self.window.rootViewController = [[SWTabBarViewController alloc] init];
    } else {
        self.window.rootViewController = [[SWOAuthViewController alloc] init];
    }
    
    //监控网络
    [SWHttpTool setReachabilityStatus:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable:
            {
                SWLog(@"没有网络");
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window.rootViewController.view animated:YES];
                
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"网络异常";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:3];
            }
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                SWLog(@"手机网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                SWLog(@"Wifi");
                break;
            default:
                break;
        }
    }];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //清除所有的内存缓存
    [[SDImageCache sharedImageCache] clearMemory];
    
    //停止真在进行的图片下载操作
    [[SDWebImageManager sharedManager] cancelAll];
    
}

@end
