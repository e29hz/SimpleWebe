//
//  SWNavigationController.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/6.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWNavigationController.h"

@interface SWNavigationController ()

@end

@implementation SWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //清空弹出手势的代理,可以恢复弹出手势
    self.interactivePopGestureRecognizer.delegate = nil;


}

+(void)initialize
{
    [[UINavigationBar appearance] setTintColor:[UIColor orangeColor]];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:15];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back" highlightedImageName:@"navigationbar_back_highlighted" target:self action:@selector(back)];
//        viewController.navigationItem.leftBarButtonItem = [UIButton buttonWithType:UIButtonTypeContactAdd];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_more" highlightedImageName:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    }
    
    [super pushViewController:viewController animated:YES];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}
@end
