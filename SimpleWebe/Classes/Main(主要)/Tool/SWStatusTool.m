//
//  SWStatusTool.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/17.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWStatusTool.h"
#import "SWHttpTool.h"

@implementation SWStatusTool

+ (void)homeStatusesWithParam:(SWHomeStatusesParam *)homeStatusesParam success:(void (^)(SWHomeStatusesResult *))success failure:(void (^)(NSError *))failure
{
    [SWBaseTool getWithUrl:@"https://api.weibo.com/2/statuses/home_timeline.json" param:homeStatusesParam resultClass:[SWHomeStatusesResult class] success:success failure:failure];
}

+ (void)sendStatusWithParam:(SWSendStatusParam *)sendStatusesParam success:(void (^)(SWSendStatusResult *result))success failure:(void(^)(NSError *error))failure
{
    [SWBaseTool postWithUrl:@"https://api.weibo.com/2/statuses/update.json" param:sendStatusesParam resultClass:[SWSendStatusResult class] success:success failure:failure];
}

@end
