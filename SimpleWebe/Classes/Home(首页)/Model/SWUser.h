//
//  SWUser.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/12.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWUser : NSObject
/**
 *  友好显示名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  用户头像地址（中图），50×50像素
 */
@property (nonatomic, copy) NSString *profile_image_url;

/**
 *  会员类型
 */
@property (nonatomic, assign) int mbtype;
/**
 *  会员等级
 */
@property (nonatomic, assign) int mbrank;

@property (nonatomic, assign, getter=isVip, readonly) BOOL vip;


@end
