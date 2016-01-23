//
//  SWUser.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/12.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWUser.h"

@implementation SWUser

- (BOOL)isVip
{
    //是会员
    return  self.mbtype > 2;
}


@end
