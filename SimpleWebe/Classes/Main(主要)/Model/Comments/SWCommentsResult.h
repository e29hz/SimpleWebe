//
//  SWCommentsResult.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/2/17.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWCommentsResult : NSObject
/** 评论数组 */
@property (nonatomic, strong) NSArray *comments;
/** 评论总数 */
@property (nonatomic, assign) int total_number;
@end
