//
//  SWPhoto.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/12.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWPhoto.h"

@implementation SWPhoto
- (void)setThumbnail_pic:(NSString *)thumbnail_pic
{
    _thumbnail_pic = [thumbnail_pic copy];
    
    self.bmiddle_pic = [thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}
@end
