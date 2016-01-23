//
//  SWDiscoverTableViewController.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/6.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWDiscoverTableViewController.h"

@interface SWDiscoverTableViewController ()

@end

@implementation SWDiscoverTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISearchBar *bar = [[UISearchBar alloc] init];
    bar.frame = CGRectMake(0, 0, 300, 35);
    self.navigationItem.titleView = bar;

}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat: @"发现测试数据----%ld", (long)indexPath.row];
    
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
