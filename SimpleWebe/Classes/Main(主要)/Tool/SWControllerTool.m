//
//  SWControllerTool.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/10.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWControllerTool.h"
#import "SWTabBarViewController.h"

@implementation SWControllerTool
+ (void)chooseRootViewController
{
    // 如何知道第一次使用这个版本？比较上次的使用情况
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    
    // 从沙盒中取出上次存储的软件版本号(取出用户上次的使用记录)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionKey];
    
    // 获得当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([currentVersion isEqualToString:lastVersion]) {
        
        window.rootViewController = [[SWTabBarViewController alloc] init];
    } else {
        window.rootViewController = [[SWTabBarViewController alloc] init];

        // 存储这次使用的软件版本
        [defaults setObject:currentVersion forKey:versionKey];
        [defaults synchronize];
    }
}
@end
