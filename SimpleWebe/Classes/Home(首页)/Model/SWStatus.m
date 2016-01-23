//
//  SWStatus.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/12.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWStatus.h"
#import "MJExtension.h"
#import "SWPhoto.h"
#import "NSDate+Extension.h"

@implementation SWStatus

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"pic_urls" : [SWPhoto class]};
}

- (NSString *)created_at
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    [formatter setLocale:locale];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    // 获得微博发布的具体时间
    NSDate *createDate = [formatter dateFromString:_created_at];
    //是否是今年
    if (createDate.isThisYear) {
        if (createDate.isToday) {
            //今天
            NSDateComponents *components = [createDate deltaWithNow];
            if (components.hour >= 1) { //至少是一小时前发的
                return [NSString stringWithFormat:@"%d小时前", (int)components.hour];
            } else if (components.minute >= 1) { //1 - 59分
                return [NSString stringWithFormat:@"%d分钟前", (int)components.minute];
            } else { // 1分内
                return @"刚刚";
            }
            
        } else if (createDate.isYesterday) {
            [formatter setDateFormat:@"昨天 HH:mm"];
            return [formatter stringFromDate:createDate];
        } else {
            [formatter setDateFormat:@"MM-dd"];
            return [formatter stringFromDate:createDate];
        }
    } else{
        //非今年
        [formatter setDateFormat:@"yyyy-MM-dd"];
        return [formatter stringFromDate:createDate];
    }
    return nil;
}

//- (NSString *)source
//{
//

//
//}

- (void)setSource:(NSString *)source
{
    // 截取范围
    if (source.length != 0) {
        NSRange range = NSMakeRange(0, 0);
        range.location = [source rangeOfString:@">"].location + 1;
        range.length = [source rangeOfString:@"</"].location - range.location;
        NSString *subSource = [source substringWithRange:range];
        
        _source = [NSString stringWithFormat:@"来自 %@", subSource];
    }
}

@end
