//
//  SWRepostsResult.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/2/18.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWRepostsResult : NSObject
/** 转发数组 */
@property (nonatomic, strong) NSArray *reposts;
/** 转发总数 */
@property (nonatomic, assign) int total_number;
@end
