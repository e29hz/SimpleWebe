//
//  SWAccountTool.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/11.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWAccountTool.h"
#import "SWAccount.h"

#define SWAccountFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]
@implementation SWAccountTool

+ (void)save:(SWAccount *)account
{
    
    //NSKeyedArchiver归档器
    [NSKeyedArchiver archiveRootObject:account toFile:SWAccountFilepath];
}

+ (SWAccount *)account;
{
    //读取账号
    SWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:SWAccountFilepath];
    
    //判断帐号是否过期
    NSDate *nowTime = [NSDate date];
    
    if ([nowTime compare:account.expires_time] != NSOrderedAscending) {
        //过期
        account = nil;
    }
    
    return account;
}

+ (void)accessTokenWithParam:(SWAccessTokenParam *)accessTokenParam success:(void(^)(SWAccount *account))success failure:(void(^)(NSError *error))failure
{
    [self postWithUrl:@"https://api.weibo.com/oauth2/access_token" param:accessTokenParam resultClass:[SWAccount class] success:success failure:failure];
}

@end
