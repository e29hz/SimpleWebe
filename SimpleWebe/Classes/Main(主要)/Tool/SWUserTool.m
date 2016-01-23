//
//  SWUserTool.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/18.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWUserTool.h"
#include "SWHttpTool.h"

@implementation SWUserTool

+ (void)userInfoWithParam:(SWUserInfoParam *)homeStatusesParam success:(void(^)(SWUserInfoResult *result))success failure:(void(^)(NSError *error))failure
{
    [SWBaseTool getWithUrl:@"https://api.weibo.com/2/users/show.json" param:homeStatusesParam resultClass:[SWUserInfoResult class] success:success failure:failure];

}

+ (void)unreadCountWithParam:(SWUnreadCountParam *)unreadCountParam success:(void(^)(SWUnreadCountResult *result))success failure:(void(^)(NSError *error))failure
{
    [SWBaseTool getWithUrl:@"https://rm.api.weibo.com/2/remind/unread_count.json" param:unreadCountParam resultClass:[SWUnreadCountResult class] success:success failure:failure];
}

@end
