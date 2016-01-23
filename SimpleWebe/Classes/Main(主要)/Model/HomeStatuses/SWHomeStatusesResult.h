//
//  SWHomeStatusesResult.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/17.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWHomeStatusesResult : NSObject
/**
 *  微博数组(装模型)
 */
@property (nonatomic, strong) NSArray *statuses;
/**
 *  近期微博总数
 */
//@property (nonatomic, assign) int *total_number;
@end
