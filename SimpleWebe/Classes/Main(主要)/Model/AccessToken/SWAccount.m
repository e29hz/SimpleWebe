//
//  SWAccount.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/10.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWAccount.h"

@implementation SWAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    SWAccount *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    
    //确定账号的过期时间
    NSDate *nowTime = [NSDate date];
    account.expires_time = [nowTime dateByAddingTimeInterval:account.expires_in.doubleValue];
    return account;
}
/**
 *  当从文件中解析出一个对象的时候调用
 *  在这个方法中写清楚:怎么解析文件中的数据
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.expires_time = [aDecoder decodeObjectForKey:@"expires_time"];
        self.name = [aDecoder decodeObjectForKey:@"name"];

        
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 *  在这个方法中写清楚:要存储那些对象的哪些属性,以及怎样存储属性
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expires_time forKey:@"expires_time"];
    [aCoder encodeObject:self.name forKey:@"name"];

}

@end
