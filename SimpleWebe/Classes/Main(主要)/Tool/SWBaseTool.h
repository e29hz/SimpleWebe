//
//  SWBaseTool.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/18.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWHttpTool.h"

@interface SWBaseTool : NSObject


+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;

+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;
@end
