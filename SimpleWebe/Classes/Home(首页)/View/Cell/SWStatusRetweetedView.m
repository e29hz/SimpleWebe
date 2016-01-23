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

@interface SWStatusRetweetedView ()

/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  正文
 */
@property (nonatomic, weak) UILabel *textLabel;

@end

@implementation SWStatusRetweetedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage resizedImage:@"timeline_retweet_background"];
        self.highlightedImage = [UIImage resizedImage:@"timeline_retweet_background_highlighted"];
        //1.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = SWColor(74, 102, 105);
        nameLabel.font = SWStatusRetweetedNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        //2.正文
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = SWStatusRetweetedTextFont;
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
    }
    return self;
}

- (void)setRetweetedFrame:(SWStatusRetweetedFrame *)retweetedFrame
{
    _retweetedFrame = retweetedFrame;
    
    self.frame = retweetedFrame.frame;
    
    // 取出微博数据
    SWStatus *retweetedStatus = retweetedFrame.retweetedStatus;
    // 取出用户数据
    SWUser *user = retweetedStatus.user;
    // 昵称
    self.nameLabel.text = [NSString stringWithFormat:@"@%@", user.name];
    self.nameLabel.frame = retweetedFrame.nameFrame;
    // 正文
    self.textLabel.text = retweetedStatus.text;
    self.textLabel.frame = retweetedFrame.textFrame;
    
}

//- (void)setFrame:(CGRect)frame
//{
//    [super setFrame:frame];
//    
//    [self setNeedsDisplay];
//}
//
//- (void)drawRect:(CGRect)rect
//{
//    [[UIImage resizedImage:[UIImage imageNamed:@"timeline_retweet_background"] drawInRect:rect];
//}

@end
