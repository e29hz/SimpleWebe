//
//  SWStatusTableViewCell.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/19.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWStatusFrame;

@interface SWStatusTableViewCell : UITableViewCell

+ (instancetype)cellWithTable:(UITableView *)tableView;

@property (nonatomic, strong) SWStatusFrame *statusFrame;

@end
