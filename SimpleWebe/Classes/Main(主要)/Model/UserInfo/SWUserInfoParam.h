//
//  SWUserInfoParam.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/18.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWBaseParam.h"

@interface SWUserInfoParam : SWBaseParam
/** 
 *  需要查询的用户ID。
 */
@property (nonatomic, copy) NSString *uid;
@end
