//
//  SWCommonCell.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/2/15.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWCommonItem;

@interface SWCommonCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  cell对应的item数据
 */
@property (nonatomic, strong) SWCommonItem *item;

@end
