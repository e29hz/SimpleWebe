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

@interface SWStatusRetweetedView ()

/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  正文
 */
@property (nonatomic, weak) SWStatusLabel *textLabel;
/**
 *  配图相册
 */
@property (nonatomic, weak) SWStatusPhotosView *photosView;

@end

@implementation SWStatusRetweetedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImage:@"timeline_retweet_background"];
        self.highlightedImage = [UIImage resizedImage:@"timeline_retweet_background_highlighted"];

        SWStatusLabel *textLabel = [[SWStatusLabel alloc] init];
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        // 微博相册
        SWStatusPhotosView *photosView = [[SWStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
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
    
}

@end
