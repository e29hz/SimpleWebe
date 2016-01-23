//
//  SWHttpTool.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/16.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface SWHttpTool : NSObject

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
+ (void)setReachabilityStatus:(void (^)(AFNetworkReachabilityStatus status))setReachabilityStatus;

+ (void)postBody:(NSString *)url params:(NSDictionary *)params constructingBody:(void(^)(id formData))constructingBody success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
@end
