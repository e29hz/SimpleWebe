//
//  SWCommonItem.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/2/15.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWCommonItem.h"

@implementation SWCommonItem
+ (instancetype)itemWithTitleAndImage:(NSString *)title icon:(NSString *)icon
{
    SWCommonItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    SWCommonItem *item = [[self alloc] init];
    item.title = title;
    return item;
}
@end
