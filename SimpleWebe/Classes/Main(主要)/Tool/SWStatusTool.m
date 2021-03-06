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
    [self getWithUrl:@"https://api.weibo.com/2/statuses/home_timeline.json" param:homeStatusesParam resultClass:[SWHomeStatusesResult class] success:success failure:failure];
}

+ (void)sendStatusWithParam:(SWSendStatusParam *)sendStatusesParam success:(void (^)(SWSendStatusResult *result))success failure:(void(^)(NSError *error))failure
{
    [self postWithUrl:@"https://api.weibo.com/2/statuses/update.json" param:sendStatusesParam resultClass:[SWSendStatusResult class] success:success failure:failure];
}

+ (void)commentsWithParam:(SWCommentsParam *)param success:(void (^)(SWCommentsResult *result))success failure:(void (^)(NSError *error))failure
{
    [self getWithUrl:@"https://api.weibo.com/2/comments/show.json" param:param resultClass:[SWCommentsResult class] success:success failure:failure];
}

+ (void)repostsWithParam:(SWRepostsParam *)param success:(void (^)(SWRepostsResult *result))success failure:(void (^)(NSError *error))failure
{
    [self getWithUrl:@"https://api.weibo.com/2/statuses/repost_timeline.json" param:param resultClass:[SWRepostsResult class] success:success failure:failure];
}

@end
