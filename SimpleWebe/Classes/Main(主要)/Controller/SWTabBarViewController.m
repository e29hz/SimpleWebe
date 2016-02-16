//
//  SWTabBarViewController.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/6.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWTabBarViewController.h"
#import "SWHomeTableViewController.h"
#import "SWMessageTableViewController.h"
#import "SWDiscoverTableViewController.h"
#import "SWProfileTableViewController.h"
#import "SWComposeViewController.h"
#import "SWUserTool.h"
#import "SWAccount.h"
#import "SWAccountTool.h"

@interface SWTabBarViewController ()<SWTabBarDelegate, UITabBarControllerDelegate>
@property (nonatomic, weak) SWHomeTableViewController *home;
@property (nonatomic, weak) SWMessageTableViewController *message;
@property (nonatomic, weak) SWProfileTableViewController *profile;
@property (nonatomic, weak) UIViewController *lastSelectedViewContoller;
@end

@implementation SWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    //添加子控制器
    [self addAllChildVcs];
    
    //添加自定义tabbar
    [self addCustomTabBar];
    
    //利用定时器获得用户未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UINavigationController *)viewController
{
    UIViewController *vc = [viewController.viewControllers firstObject];
    if ([vc isKindOfClass:[SWHomeTableViewController class]]) {
        if (self.lastSelectedViewContoller == vc) {
            [self.home refresh:YES];
        } else {
            [self.home refresh:NO];
        }
    }
    
    self.lastSelectedViewContoller = vc;
}

- (void)getUnreadCount
{
    //请求参数
    SWUnreadCountParam *param = [SWUnreadCountParam param];
    param.uid = [SWAccountTool account].uid;
    //获得未读数
    [SWUserTool unreadCountWithParam:param success:^(SWUnreadCountResult *result) {
        // 显示微博未读数
        if (result.status == 0) {
            self.home.tabBarItem.badgeValue = nil;
        } else {
            self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        }
        
        // 显示消息未读数
        if (result.messageCount == 0) {
            self.message.tabBarItem.badgeValue = nil;
        } else {
            self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        }
        
        // 显示新粉丝数
        if (result.follower == 0) {
            self.profile.tabBarItem.badgeValue = nil;
        } else {
            self.profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        }
        
        // 在图标上显示所有的未读数
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil]];
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;

        
    } failure:^(NSError *error) {
        SWLog(@"获取未读数失败----------%@", error);
    }];
}

- (void)addCustomTabBar
{
    SWTabBar *customTabBar = [[SWTabBar alloc] init];
    customTabBar.tabBarDelegate = self;
    
    
    [self setValue:customTabBar forKeyPath:@"tabBar"];
}

- (void)addAllChildVcs
{
    SWHomeTableViewController *home = [[SWHomeTableViewController alloc] init];
    [self addOneChildVc:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.home = home;
    
    SWMessageTableViewController *message = [[SWMessageTableViewController alloc] init];
    [self addOneChildVc:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    self.message = message;
    
    SWDiscoverTableViewController *discover = [[SWDiscoverTableViewController alloc] init];
    [self addOneChildVc:discover title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    SWProfileTableViewController *profile = [[SWProfileTableViewController alloc] init];
    [self addOneChildVc:profile title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    self.profile = profile;
}

+(void)initialize
{
    [[UITabBar appearance] setTintColor:[UIColor orangeColor]];
}


- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
//    childVc.view.backgroundColor = SWRandomColor;
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    SWNavigationController *navVc = [[SWNavigationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:navVc];
}

#pragma mark - SWTabBarDelegate

- (void)tabBarDidClickedPlusButton:(SWTabBar *)tabBar
{
    //弹出发微博控制器
    SWComposeViewController *compose = [[SWComposeViewController alloc] init];
    SWNavigationController *nav = [[SWNavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
    
    
    
}

@end
