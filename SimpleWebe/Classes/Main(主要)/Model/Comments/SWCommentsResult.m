//
//  SWCommentsResult.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/2/17.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWCommentsResult.h"
#import "MJExtension.h"
#import "SWComment.h"

@implementation SWCommentsResult
- (NSDictionary *)objectClassInArray
{
    return @{@"comments" : [SWComment class]};

}

@end