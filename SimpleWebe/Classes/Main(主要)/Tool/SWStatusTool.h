//
//  SWStatusTool.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/17.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWHomeStatusesParam.h"
#import "SWHomeStatusesResult.h"
#import "SWSendStatusParam.h"
#import "SWSendStatusResult.h"
#import "SWBaseTool.h"

@interface SWStatusTool : NSObject
/**
 *  加载首页微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)homeStatusesWithParam:(SWHomeStatusesParam *)homeStatusesParam success:(void (^)(SWHomeStatusesResult *result))success failure:(void(^)(NSError *error))failure;

/**
 *  发没有图片微博
 *
 *  @param param   请求参数
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)sendStatusWithParam:(SWSendStatusParam *)sendStatusesParam success:(void (^)(SWSendStatusResult *result))success failure:(void(^)(NSError *error))failure;

@end
