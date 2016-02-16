//
//  SWDiscoverTableViewController.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/6.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWDiscoverTableViewController.h"
#import "SWCommonGroup.h"
#import "SWCommonItem.h"
#import "SWCommonCell.h"
#import "SWCommonSwitchItem.h"
#import "SWCommonArrowItem.h"
#import "SWCommonLabelItem.h"

@interface SWDiscoverTableViewController ()
@end

@implementation SWDiscoverTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSearchBar];
    
    //初始化模型数据
    [self setupGroups];
    
    
}

- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0
{
    SWCommonGroup *group = [SWCommonGroup group];
    [self.groups addObject:group];

    //设置组的所有行数据
    SWCommonArrowItem *hotStatus = [SWCommonArrowItem itemWithTitle:@"热门微博" icon:@"hot_status"];
    hotStatus.subtitle = @"笑话，娱乐，神最右都搬到这啦";
    hotStatus.destVcClass = [self class];
    
    SWCommonArrowItem *findPeople = [SWCommonArrowItem itemWithTitle:@"找人" icon:@"find_people"];
    findPeople.subtitle = @"名人、有意思的人尽在这里";
    
    group.items = @[hotStatus, findPeople];
    
}

- (void)setupGroup1
{
    SWCommonGroup *group = [SWCommonGroup group];
    [self.groups addObject:group];
    //设置组的所有行数据
    SWCommonArrowItem *gameCenter = [SWCommonArrowItem itemWithTitle:@"游戏中心" icon:@"game_center"];
    gameCenter.badgeValue = @"99";
    SWCommonArrowItem *near = [SWCommonArrowItem itemWithTitle:@"周边" icon:@"near"];
    SWCommonArrowItem *app = [SWCommonArrowItem itemWithTitle:@"应用" icon:@"app"];
    
    group.items = @[gameCenter, near, app];
}

- (void)setupGroup2
{
    SWCommonGroup *group = [SWCommonGroup group];
    [self.groups addObject:group];
    // 设置组的所有行数据
    SWCommonArrowItem *video = [SWCommonArrowItem itemWithTitle:@"视频" icon:@"video"];
    video.operation = ^{
        SWLog(@"---点击了视频---");
    };
    SWCommonArrowItem *music = [SWCommonArrowItem itemWithTitle:@"音乐" icon:@"music"];
    music.operation = ^{
        SWLog(@"---点击了音乐---");
    };
    SWCommonArrowItem *movie = [SWCommonArrowItem itemWithTitle:@"电影" icon:@"movie"];
    movie.operation = ^{
        SWLog(@"---点击了电影---");
    };
    SWCommonArrowItem *cast = [SWCommonArrowItem itemWithTitle:@"播客" icon:@"cast"];
    cast.operation = ^{
        SWLog(@"---点击了播客---");
    };
    SWCommonArrowItem *more = [SWCommonArrowItem itemWithTitle:@"更多" icon:@"more"];
    more.operation = ^{
        SWLog(@"---点击了更多---");
    };
    
    group.items = @[video, music, movie, cast, more];
}

- (void)setupSearchBar
{
    UISearchBar *bar = [[UISearchBar alloc] init];
    bar.placeholder = @"点击此处搜索";
    bar.frame = CGRectMake(0, 0, 300, 35);
    self.navigationItem.titleView = bar;
}

@end