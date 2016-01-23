//
//  UIBarButtonItem+SWExtension.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/7.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SWExtension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName target:(id)target action:(SEL)action
;
@end
