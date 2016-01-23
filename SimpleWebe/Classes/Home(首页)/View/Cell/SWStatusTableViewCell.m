
//
//  SWStatusTableViewCell.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/19.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWStatusTableViewCell.h"
#import "SWStatusDetailView.h"
#import "SWStatusToolbar.h"
#import "SWStatusFrame.h"

@interface SWStatusTableViewCell()
@property (nonatomic, weak) SWStatusDetailView *detailView;
@property (nonatomic, weak) SWStatusToolbar *toolbar;

@end

@implementation SWStatusTableViewCell

+ (instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    SWStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SWStatusTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //添加微博具体内容
        [self setupDetailView];
        //添加工具条
        [self setupToolbar];
        
        //设置cell
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
/**
 *  添加微博具体内容
 */
- (void)setupDetailView
{
    SWStatusDetailView *detailView = [[SWStatusDetailView alloc] init];
    [self.contentView addSubview:detailView];
    self.detailView = detailView;
}
/**
 *  添加工具条
 */
- (void)setupToolbar
{
    SWStatusToolbar *toolbar = [[SWStatusToolbar alloc] init];
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
}

- (void)setStatusFrame:(SWStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    //微博具体内容的frame数据
    self.detailView.detailFrame = statusFrame.detailFrame;
    
    //底部工具条的frame数据
    self.toolbar.frame = statusFrame.toolbarFrame;
    self.toolbar.status = statusFrame.status;
}
@end
