//
//  SWHomeTableViewController.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/6.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWHomeTableViewController.h"
#import "SWAccountTool.h"
#import "SWAccount.h"
#import "SWStatus.h"
#import "SWStatusFrame.h"
#import "SWLoadMoreFooter.h"
#import "SWHttpTool.h"
#import "SWStatusTool.h"
#import "SWUserInfoParam.h"
#import "SWUserInfoResult.h"
#import "SWUserTool.h"
#import "SWStatusTableViewCell.h"
#import "SWStatusDetailViewController.h"

@interface SWHomeTableViewController ()
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSMutableArray *statusFrames;
@property (nonatomic, weak) SWLoadMoreFooter *footer;


@end

@implementation SWHomeTableViewController

@synthesize refreshControl = _refreshControl;

- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames =[NSMutableArray array];
    }
    return _statusFrames;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = SWGlobalBackground;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    //设置导航栏内容
    [self setupNavBar];
    
    //集成刷新控件
    [self setupRefresh];
    
    //获取用户信息
    [self getUserInfo];
    
    //监听链接选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(linkDidSelected:) name:SWLinkDidSelectedNotification object:nil];
     
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)linkDidSelected:(NSNotification *)notification
{
    NSString *link = notification.userInfo[SWLink];
    if ([link hasPrefix:@"http"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
    } else {
        //跳转控制器
        SWLog(@"非http链接---%@", link);
    }
}

/**
 *  获取用户信息
 */
- (void)getUserInfo
{
    SWUserInfoParam *param = [SWUserInfoParam param];
    param.uid = [SWAccountTool account].uid;
    
    [SWUserTool userInfoWithParam:param success:^(SWUserInfoResult *result) {
        SWUser *user = result;
        
        self.navigationItem.title = user.name;
        
        //存储用户信息
        SWAccount *account = [SWAccountTool account];
        account.name = user.name;
        [SWAccountTool save:account];
    } failure:^(NSError *error) {
        
        SWLog(@"getUserInfo请求失败------%@", error);
    }];

}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:refreshControl];
    self.refreshControl = refreshControl;
    //监听状态
    [refreshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    //自动进入刷新状态
    [refreshControl beginRefreshing];
    //加载数据
    [self refreshControlStateChange:refreshControl];
    // 5.添加上拉加载更多控件
    SWLoadMoreFooter *footer = [SWLoadMoreFooter footer];
    self.tableView.tableFooterView = footer;
    self.footer = footer;
}
/**
 *  当下拉刷新空间进入刷新状态
 */
- (void)refreshControlStateChange:(UIRefreshControl *)refreshControl
{
    [self loadNewStatuses:refreshControl];
}

- (void)refresh:(BOOL)fromSelf
{
    if (self.tabBarItem.badgeValue) { // 有数字
        
        // 转圈圈
        [self.refreshControl beginRefreshing];
        
        // 刷新数据
        [self loadNewStatuses:self.refreshControl];
    } else if (fromSelf) { // 没有数字
        // 让表格回到最顶部
        NSIndexPath *firstRow = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:firstRow atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

#pragma mark - 加载微博数据
/**
 *  根据微博数组 转成 frame模型数组
 */
- (NSArray *)statusFrameWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (SWStatus *status in statuses) {
        SWStatusFrame *frame = [[SWStatusFrame alloc] init];
        //传递微博模型数据,计算所有子空间的frame
        frame.status = status;
        [frames addObject:frame];
    }
    return frames;
}

/**
 *  加载最新的微博数据
 */
- (void)loadNewStatuses:(UIRefreshControl *)refreshControl
{
    //封装请求参数
    SWHomeStatusesParam *param = [SWHomeStatusesParam param];
    SWStatusFrame *firstStatusFrame = [self.statusFrames firstObject];
    SWStatus *firstStatus = firstStatusFrame.status;
    if (firstStatus) {
        param.since_id = @([firstStatus.idstr longLongValue]);
    }
    
    //加载微博数据
    [SWStatusTool homeStatusesWithParam:param success:^(SWHomeStatusesResult *result) {
        //将微博数组转成微博frame数组
        NSArray *newFrames = [self statusFrameWithStatuses:result.statuses];
        
        //将新数据插入到旧数据的前面
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:indexSet];
        
        //重新刷新表格
        [self.tableView reloadData];
        
        //停止刷新控件
        [refreshControl endRefreshing];
        //提示最新微博数量
        [self showNewStatusesCount:(int)newFrames.count];
    } failure:^(NSError *error) {
        SWLog(@"loadNewStatuses请求失败--%@", error);
        //停止刷新控件
        [refreshControl endRefreshing];
    }];
}

/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatuses
{
    //封装请求参数
    SWHomeStatusesParam *param = [SWHomeStatusesParam param];
    SWStatusFrame *lastStatusFrame = [self.statusFrames lastObject];
    SWStatus *lastStatus = lastStatusFrame.status;
    if (lastStatus) {
        param.max_id = @([lastStatus.idstr longLongValue] - 1);
    }
    //加载微博数据
    [SWStatusTool homeStatusesWithParam:param success:^(SWHomeStatusesResult *result) {
        //将微博数组转成微博frame数组
        NSArray *newFrames = [self statusFrameWithStatuses:result.statuses];
        // 将新数据插入到旧数据的最后面
        [self.statusFrames addObjectsFromArray:newFrames];
        
        // 重新刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止刷新（恢复默认的状态）
        [self.footer endRefreshing];
    } failure:^(NSError *error) {
        SWLog(@"loadMoreStatuses请求失败--%@", error);
        // 让刷新控件停止刷新（恢复默认的状态）
        [self.footer endRefreshing];
    }];
}

/**
 *  提示最新微博数量
 */
- (void)showNewStatusesCount:(int)count
{
    int totalNumber = (int)[UIApplication sharedApplication].applicationIconBadgeNumber - self.tabBarItem.badgeValue.intValue;
    [UIApplication sharedApplication].applicationIconBadgeNumber = totalNumber;
    
    self.tabBarItem.badgeValue = nil;
    
    //创建一个Label
    UILabel *label = [[UILabel alloc] init];
    
    if (count) {
        label.text = [NSString stringWithFormat:@"共有%d条新的微博数据",count];
    }
    else
    {
        label.text = @"没有最新的微博数据";
    }
    //设置背景
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    //设置frame
    label.width = self.view.width;
    label.height = 35;
    label.x = 0;
    label.y = 64 - label.height;
    
    //添加到导航控制器的View
    //    [self.navigationController.view addSubview:label];
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //动画
    CGFloat duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        //向下移动一个label的高度
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:duration delay:duration options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //回到原来的位置
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
        
    }];
    
}



/**
 *  设置导航栏内容
 */
- (void)setupNavBar
{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" highlightedImageName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendSearch)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop" highlightedImageName:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];

    NSString *name = [SWAccountTool account].name;

    if (name == nil) {
        self.navigationItem.title = @"首页";
    }
    else
    {
        self.navigationItem.title = name;
    }
}



- (void)friendSearch
{
    SWLog(@"friendSearch-----");
}

- (void)pop
{
    SWLog(@"pop--------------");
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    tableView.tableFooterView.hidden = self.statusFrames.count == 0;
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWStatusTableViewCell *cell = [SWStatusTableViewCell cellWithTable:tableView];
    
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}
#pragma mark - tableView代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.statusFrames.count <= 0 || self.footer.isRefreshing) return;
    
    // 1.差距
    CGFloat delta = scrollView.contentSize.height - scrollView.contentOffset.y;
    // 刚好能完整看到footer的高度
    CGFloat sawFooterH = self.view.height - self.tabBarController.tabBar.height;
    
    // 2.如果能看见整个footer
    if (delta <= (sawFooterH - 0)) {
        // 进入上拉刷新状态
        [self.footer beginRefreshing];
        // 加载更多的微博数据
        [self loadMoreStatuses];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//            
//        });
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWStatusDetailViewController *detailVc = [[SWStatusDetailViewController alloc] init];
    SWStatusFrame *frame = self.statusFrames[indexPath.row];
    detailVc.status = frame.status;
    [self.navigationController  pushViewController:detailVc animated:YES];
}

@end
