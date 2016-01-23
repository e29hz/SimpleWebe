//
//  UIImage+Extension.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/7.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  根据图片名返回一张能够自由拉伸的图片
 */
+ (UIImage *)resizedImage:(NSString *)name;
@end
