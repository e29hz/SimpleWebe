//
//  SWStatusOriginalView.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/19.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWStatusOriginalView.h"
#import "SWStatusOriginalFrame.h"
#import "SWStatus.h"
#import "SWUser.h"
#import "SWStatusPhotosView.h"
#import "SWStatusLabel.h"


@interface SWStatusOriginalView ()
/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  正文
 */
@property (nonatomic, weak) SWStatusLabel *textLabel;
/**
 *  时间
 */
@property (nonatomic, weak) UILabel *timeLabel;
/**
 *  来源
 */
@property (nonatomic, weak) UILabel *sourceLabel;
/**
 *  头像
 */
@property (nonatomic, weak) UIImageView *iconView;
/**
 *  会员图标
 */
@property (nonatomic, weak) UIImageView *vipView;
/**
 *  配图相册
 */
@property (nonatomic, weak) SWStatusPhotosView *photosView;
@end

@implementation SWStatusOriginalView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = SWStatusOrginalNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;

        // 正文
        
        SWStatusLabel *textLabel = [[SWStatusLabel alloc] init];
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        // 时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = SWStatusOrginalTimeFont;
        timeLabel.textColor = [UIColor orangeColor];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        // 来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = SWStatusOrginalSourceFont;
        sourceLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        // 头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        // 会员图标
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        // 微博相册
        
        SWStatusPhotosView *photosView = [[SWStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
}

- (void)setOriginalFrame:(SWStatusOriginalFrame *)originalFrame
{
    _originalFrame = originalFrame;
    
    SWStatus *status = originalFrame.status;
    SWUser *user = status.user;
    self.frame = originalFrame.frame;
    
    // 昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = originalFrame.nameFrame;
    if (user.isVip) { //会员图标
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipView.hidden = NO;
        self.vipView.frame = originalFrame.vipFrame;
        self.vipView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    // 正文
    if (status.isRetweeted) {
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:status.attributedText];
        NSInteger len = user.name.length + 3;
        [text deleteCharactersInRange:NSMakeRange(0, len)];
        self.textLabel.attributedText = text;
    } else {
        self.textLabel.attributedText = status.attributedText;
    }
    self.textLabel.frame = originalFrame.textFrame;
    // 时间
    NSString *time = status.created_at;
    //时间frame
    CGFloat timeX = CGRectGetMinX(originalFrame.nameFrame);
    CGFloat timeY = CGRectGetMaxY(originalFrame.nameFrame) + SWStatusCellInset * 0.5;
    CGSize timeSize = [time sizeWithAttributes:SWStatusOriginalTimeFontAttribute];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    self.timeLabel.text = time;
    // 来源
    //来源frame
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + SWStatusCellInset;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithAttributes:SWStatusOriginalSourceFontAttribute];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    self.sourceLabel.text = status.source;

    
    // 头像
    self.iconView.frame = originalFrame.iconFrame;
    NSString *imageUrlStr = user.profile_image_url;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    // 配图相册
    if (status.pic_urls.count) {
        self.photosView.frame = originalFrame.photosFrame;
        self.photosView.pic_urls = originalFrame.status.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
    
    
    
    
}

@end
