//
//  SWAccount.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/10.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWAccount : NSObject <NSCoding>

/** 用于调用access_token，接口获取授权后的access token */
@property (nonatomic, copy) NSString *access_token;

/** access_token的生命周期，单位是秒数 */
@property (nonatomic, copy) NSString *expires_in;

/** 过期时间 */
@property (nonatomic, strong) NSDate *expires_time;


/** 当前授权用户的UID */
@property (nonatomic, copy) NSString *uid;
/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;



+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
