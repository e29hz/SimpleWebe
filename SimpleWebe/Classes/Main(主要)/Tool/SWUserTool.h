//
//  SWUserTool.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/18.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWUserInfoParam.h"
#import "SWUserInfoResult.h"
#import "SWBaseTool.h"
#import "SWUnreadCountParam.h"
#import "SWUnreadCountResult.h"

@interface SWUserTool : NSObject
/**
 *  加载用户个人信息
 *
 *  @param param   请求参数
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)userInfoWithParam:(SWUserInfoParam *)homeStatusesParam success:(void(^)(SWUserInfoResult *result))success failure:(void(^)(NSError *error))failure;
/**
 *  获取用户未读数
 *
 *  @param param   请求参数
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)unreadCountWithParam:(SWUnreadCountParam *)unreadCountParam success:(void(^)(SWUnreadCountResult *result))success failure:(void(^)(NSError *error))failure;
@end
