//
//  SWBaseTool.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/18.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWBaseTool.h"

@implementation SWBaseTool

+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void(^)(id result))success failure:(void(^)(NSError *error))failure
{
    NSDictionary *params = [param mj_keyValues];
    [SWHttpTool get:url params:params success:^(id responseObject) {
        if (success) {
//            SWLog(@"--------------------------------------------\n%@", responseObject);
            id result = [resultClass mj_objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void(^)(id result))success failure:(void(^)(NSError *error))failure
{
    NSDictionary *params = [param mj_keyValues];
    [SWHttpTool post:url params:params success:^(id responseObject) {
        if (success) {
            id result = [resultClass mj_objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
