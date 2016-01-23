//
//  SWHomeStatusesResult.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/17.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWHomeStatusesResult.h"
#import "MJExtension.h"
#import "SWStatus.h"

@implementation SWHomeStatusesResult
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"statuses" : [SWStatus class]};

}
@end
