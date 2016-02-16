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
@property (nonatomic, strong) NSMutableArray *groups;
@end

@implementation SWDiscoverTableViewController

/**
 用一个模型来描述没组的信息:组头,组尾,所有的行模型
 用一个模型来描述每行的信息:图标,标题,子标题,右边的样式(箭头,文字,开关...)
 */

- (NSMutableArray *)groups
{
    if (!_groups) {
        self.groups = [NSMutableArray array];
        
    }
    return _groups;
}

/**
 *  屏蔽tableView的样式
 */
- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSearchBar];
    //设置tableView的属性
    self.tableView.backgroundColor = SWGlobalBackground;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = SWStatusCellMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(SWStatusCellMargin - 30, 0, 0, 0);
    
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
    SWCommonArrowItem *music = [SWCommonArrowItem itemWithTitle:@"音乐" icon:@"music"];
    SWCommonArrowItem *movie = [SWCommonArrowItem itemWithTitle:@"电影" icon:@"movie"];
    SWCommonArrowItem *cast = [SWCommonArrowItem itemWithTitle:@"播客" icon:@"cast"];
    SWCommonArrowItem *more = [SWCommonArrowItem itemWithTitle:@"更多" icon:@"more"];
    
    group.items = @[video, music, movie, cast, more];
}

- (void)setupSearchBar
{
    UISearchBar *bar = [[UISearchBar alloc] init];
    bar.placeholder = @"点击此处搜索";
    bar.frame = CGRectMake(0, 0, 300, 35);
    self.navigationItem.titleView = bar;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SWCommonGroup *group = self.groups[section];
    return group.items.count;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWCommonCell *cell = [SWCommonCell cellWithTableView:tableView];
    SWCommonGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    //cell所处的行号 和所处组的总行数
    [cell setIndexPath:indexPath rowsInSection:group.items.count];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *newVc = [[UIViewController alloc] init];
    newVc.view.backgroundColor = SWRandomColor;
    newVc.title = @"newVc";
    [self.navigationController pushViewController:newVc animated:YES];
}



@end
