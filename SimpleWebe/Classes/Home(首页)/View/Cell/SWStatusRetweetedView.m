//
//  SWStatusRetweetedView.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/19.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWStatusRetweetedView.h"
#import "SWStatusRetweetedFrame.h"
#import "SWStatus.h"
#import "SWUser.h"
#import "SWStatusPhotosView.h"
#import "SWStatusLabel.h"
#import "SWStatusRetweetedToolbar.h"
#import "SWStatusDetailViewController.h"

@interface SWStatusRetweetedView ()

/**
 *  正文
 */
@property (nonatomic, weak) SWStatusLabel *textLabel;
/**
 *  配图相册
 */
@property (nonatomic, weak) SWStatusPhotosView *photosView;
/**
 *  工具条
 */
@property (nonatomic, weak) SWStatusRetweetedToolbar *toolbar;

@end

@implementation SWStatusRetweetedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImage:@"timeline_retweet_background"];
        self.highlightedImage = [UIImage resizedImage:@"timeline_retweet_background_highlighted"];
        //正文
        SWStatusLabel *textLabel = [[SWStatusLabel alloc] init];
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        // 微博相册
        SWStatusPhotosView *photosView = [[SWStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
        //工具条
        SWStatusRetweetedToolbar *toolbar = [[SWStatusRetweetedToolbar alloc] init];
        [self addSubview:toolbar];
        self.toolbar = toolbar;
        
        // 添加手势监听器
        
    
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //跳转控制器
    UITabBarController *tabbarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //当前选中的控制器
    UINavigationController *nav = (UINavigationController *)tabbarVc.selectedViewController;
    
    //push微博详情控制器
    SWStatusDetailViewController *detailVc = [[SWStatusDetailViewController alloc] init];
    
    detailVc.status = self.retweetedFrame.retweetedStatus;
    [nav pushViewController:detailVc animated:YES];
    
}

- (void)setRetweetedFrame:(SWStatusRetweetedFrame *)retweetedFrame
{
    _retweetedFrame = retweetedFrame;
    
    self.frame = retweetedFrame.frame;
    
    // 取出微博数据
    SWStatus *retweetedStatus = retweetedFrame.retweetedStatus;
    
    // 正文
    self.textLabel.attributedText = retweetedStatus.attributedText;
    self.textLabel.frame = retweetedFrame.textFrame;
    
    // 配图相册
    if (retweetedStatus.pic_urls.count) {
        self.photosView.frame = retweetedFrame.photosFrame;
        self.photosView.pic_urls = retweetedStatus.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
    // 工具条
    if (retweetedStatus.isDetail) {
        self.toolbar.frame = retweetedFrame.toolbarFrame;
        self.toolbar.status = retweetedFrame.retweetedStatus;
        self.toolbar.hidden = NO;
    } else {
        self.toolbar.hidden = YES;
    }
    
    
    
}

@end
