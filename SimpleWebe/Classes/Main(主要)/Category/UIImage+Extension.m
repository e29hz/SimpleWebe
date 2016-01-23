//
//  UIImage+Extension.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/7.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
@end
