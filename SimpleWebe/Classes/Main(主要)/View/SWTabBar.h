//
//  SWTabBar.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/9.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWTabBar;

@protocol SWTabBarDelegate <NSObject>

@optional
- (void)tabBarDidClickedPlusButton:(SWTabBar *)tabBar;

@end

@interface SWTabBar : UITabBar
@property (nonatomic, weak) id<SWTabBarDelegate> tabBarDelegate;
@end
