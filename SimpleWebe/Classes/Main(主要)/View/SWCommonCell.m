//
//  SWCommonCell.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/2/15.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWCommonCell.h"
#import "SWCommonItem.h"
#import "SWCommonGroup.h"

@implementation SWCommonCell

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"common";
    SWCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SWCommonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 设置标题的字体
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

#pragma mark - 调整子控件的位置
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    // 调整子标题的x
//    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 10;
//}


#pragma mark - setter
- (void)setItem:(SWCommonItem *)item
{
    _item = item;
    
    // 1.设置基本数据
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
}


@end
