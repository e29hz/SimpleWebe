//
//  UIBarButtonItem+SWExtension.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/7.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "UIBarButtonItem+SWExtension.h"

@implementation UIBarButtonItem (SWExtension)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
