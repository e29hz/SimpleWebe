//
//  SWBaseParam.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/18.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWBaseParam.h"
#import "SWAccountTool.h"

@implementation SWBaseParam
- (id)init
{
    if (self = [super init]) {
        self.access_token = [SWAccountTool account].access_token;
    }
    return self;
}

+ (instancetype)param
{
    return [[self alloc] init];
}
@end
