//
//  SWCommonGroup.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/2/15.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWCommonGroup : NSObject
/**
 *  组头
 */
@property (nonatomic, copy) NSString *header;
/**
 *  组尾
 */
@property (nonatomic, copy) NSString *footer;
/**
 *  行模型
 */
@property (nonatomic, strong) NSArray *items;

+ (instancetype)group;


@end
