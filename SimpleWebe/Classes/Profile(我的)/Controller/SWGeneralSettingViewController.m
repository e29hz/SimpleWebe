//
//  SWGeneralSettingViewController.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/2/16.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWGeneralSettingViewController.h"
#import "SWCommonGroup.h"
#import "SWCommonItem.h"
#import "SWCommonArrowItem.h"
#import "SWCommonSwitchItem.h"
#import "SWCommonLabelItem.h"
#import "MBProgressHUD.h"

@interface SWGeneralSettingViewController ()

@end

@implementation SWGeneralSettingViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGroups];
}

/**
 *  初始化模型数据
 */
- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
}

- (void)setupGroup0
{
    // 1.创建组
    SWCommonGroup *group = [SWCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    SWCommonLabelItem *readMdoe = [SWCommonLabelItem itemWithTitle:@"阅读模式"];
    
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *imageCachePath = [caches stringByAppendingString:@"/com.hackemist.SDWebImageCache"];
    
    long long fileSize = [self fileSizeAtFile:imageCachePath];
    readMdoe.text = [NSString stringWithFormat:@"(%.1fM)", fileSize / (1024.0 * 1024.0)];
    
    
    group.items = @[readMdoe];
}

- (void)setupGroup1
{
    // 1.创建组
    SWCommonGroup *group = [SWCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    SWCommonArrowItem *clearCache = [SWCommonArrowItem itemWithTitle:@"清除图片缓存"];
    clearCache.subtitle = @"1.5M";
    clearCache.operation = ^{
        [self hud:@"正在清除缓存"];
        
        
    };
    
    group.items = @[clearCache];
}
/**
 *  计算某个文件夹的大小
 *
 *  @param file 文件的路径
 */
- (long long)fileSizeAtFile:(NSString *)file
{
    //文件管理
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    NSDictionary *attr = [mgr attributesOfItemAtPath:file error:nil];
    SWLog(@"%@", attr);
    return  [attr[NSFileSize] longLongValue];
}
    

- (void)hud:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows firstObject] animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:3];
    
}

@end
