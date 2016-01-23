//
//  SWLoadMoreFooter.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/12.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWLoadMoreFooter.h"

@interface SWLoadMoreFooter()

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadActivityView;

@end

@implementation SWLoadMoreFooter

+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SWLoadMoreFooter" owner:nil options:nil] lastObject];
}

- (void)beginRefreshing
{
    self.statusLabel.text = @"正在加载数据...";
    [self.loadActivityView startAnimating];
    self.refreshing = YES;
}

- (void)endRefreshing
{
    self.statusLabel.text = @"向上加载更多";
    [self.loadActivityView stopAnimating];
    self.refreshing = NO;
}

@end
