//
//  SWAccountTool.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/11.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWBaseTool.h"
#import "SWAccessTokenParam.h"
@class SWAccount;


@interface SWAccountTool : SWBaseTool

/**
 *  存储帐号
 */
+ (void)save:(SWAccount *)account;

/**
 *  读取帐号
 */
+ (SWAccount *)account;

/**
 *  获得accessToken
 *
 *  @param param   请求参数
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)accessTokenWithParam:(SWAccessTokenParam *)accessTokenParam success:(void(^)(SWAccount *account))success failure:(void(^)(NSError *error))failure;

@end
