//
//  SWStatusDetailViewController.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/2/16.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWStatusDetailViewController.h"
#import "SWStatusTableViewCell.h"
#import "SWStatus.h"
#import "SWStatusDetailView.h"
#import "SWStatusDetailFrame.h"
#import "SWStatusFrame.h"
#import "SWStatusDetailBottomToolbar.h"
#import "SWStatusDetailTopToolbar.h"
#import "SWCommentsParam.h"
#import "SWCommentsResult.h"
#import "SWComment.h"
#import "SWStatusTool.h"

@interface SWStatusDetailViewController ()<UITableViewDataSource, UITableViewDelegate, SWStatusDetailTopToolbarDelegate>
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) SWStatusDetailTopToolbar *topToolbar;

@property (nonatomic, strong) NSMutableArray *comments;


@end

@implementation SWStatusDetailViewController

- (NSMutableArray *)comments
{
    if (_comments == nil) {
        self.comments = [NSMutableArray array];
    }
    return _comments;
}

- (SWStatusDetailTopToolbar *)topToolbar
{
    if (!_topToolbar) {
        self.topToolbar = [SWStatusDetailTopToolbar toolbar];
        self.topToolbar.status = self.status;
        self.topToolbar.delegate = self;
    }
    return _topToolbar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微博正文";
    //创建tableView
    [self setupTableView];
    
    //创建微博详情控件
    [self setupDetailView];
    
    //创建底部工具条
    [self setupBottomToolbar];
    

}
- (void)setupBottomToolbar
{
    SWStatusDetailBottomToolbar *bottomToolbar = [[SWStatusDetailBottomToolbar alloc] init];
    bottomToolbar.y = CGRectGetMaxY(self.tableView.frame);
    bottomToolbar.width = self.view.width;
    bottomToolbar.height = self.view.height - self.tableView.height;
    [self.view addSubview:bottomToolbar];
}
/**
 *  创建tableView
 */
- (void)setupTableView
{
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.width = self.view.width;
    tableView.height = self.view.height - 44;
    self.tableView.backgroundColor = SWGlobalBackground;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
/**
 *  创建详情控件
 */
- (void)setupDetailView
{
    //设置微博详情
    SWStatusDetailView *detailView = [[SWStatusDetailView alloc] init];
    //创建frame对象
    SWStatusDetailFrame *frame = [[SWStatusDetailFrame alloc] init];
    self.status.retweeted_status.detail = YES;
    frame.status =self.status;
    //传递frame数据
    detailView.detailFrame = frame;
    //设置微博详情的高度
    detailView.height = frame.frame.size.height;
    self.tableView.tableHeaderView = detailView;
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    SWComment *cmt = [SWComment mj_objectWithKeyValues:self.comments[indexPath.row]];
    cell.textLabel.text = cmt.text;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.topToolbar;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.topToolbar.height;
}

#pragma mark - 顶部工具条的代理
- (void)topToolbar:(SWStatusDetailTopToolbar *)topToolbar didSelectedButton:(SWStatusDetailTopToolbarButtonType)buttonType
{
    switch (buttonType) {
        case SWStatusDetailTopToolbarButtonTypeComment: // 评论
            [self loadComments];
            break;
            
        case SWStatusDetailTopToolbarButtonTypeRetweeted: // 转发
            [self loadRetweeteds];
            break;
    }
}

/**
 *  加载评论数据
 */
- (void)loadComments
{
    SWCommentsParam *param = [SWCommentsParam param];
    param.id = self.status.idstr;
    SWComment *cmt = [SWComment mj_objectWithKeyValues:[self.comments firstObject]];
            param.since_id = cmt.idstr;
    
    [SWStatusTool commentsWithParam:param success:^(SWCommentsResult *result) {
        // 评论总数
        self.status.comments_count = result.total_number;
        self.topToolbar.status = self.status;
        
        // 累加评论数据
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.comments.count)];
        [self.comments insertObjects:result.comments atIndexes:set];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}


/**
 *  加载转发数据
 */
- (void)loadRetweeteds
{
    SWLog(@"loadRetweeteds");
}


@end
