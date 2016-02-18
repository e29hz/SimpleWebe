//
//  SWRepostsResult.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/2/18.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWRepostsResult.h"
#import "MJExtension.h"
#import "SWStatus.h"

@implementation SWRepostsResult
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"reposts" : [SWStatus class]};
}
@end
