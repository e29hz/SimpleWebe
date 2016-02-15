//
//  SWStatusRetweetedFrame.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/20.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWStatusRetweetedFrame.h"
#import "SWStatus.h"
#import "SWUser.h"
#import "SWStatusPhotosView.h"

@implementation SWStatusRetweetedFrame

- (void)setRetweetedStatus:(SWStatus *)retweetedStatus
{
    _retweetedStatus = retweetedStatus;
    
//    //昵称
//    CGFloat nameX = SWStatusCellInset;
//    CGFloat nameY = SWStatusCellInset;
//    NSString *name = [NSString stringWithFormat:@"@%@", retweetedStatus.user.name];
//    CGSize nameSize = [name sizeWithAttributes:SWStatusRetweetedNameFontAttribute];
//    //    self.iconFrame = CGRectMake(nameX, nameY, iconW, iconH);
//    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};

    //正文
    CGFloat textX = SWStatusCellInset;
    CGFloat textY = CGRectGetMaxY(self.nameFrame) + SWStatusCellInset;
    CGFloat maxW = SWScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [retweetedStatus.attributedText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.textFrame = (CGRect){{textX, textY}, textSize};

    CGFloat h = 0;
    //配图相册frame
    if (retweetedStatus.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + SWStatusCellInset;
        CGSize photosSize = [SWStatusPhotosView sizeWithPhotosCount:(int)retweetedStatus.pic_urls.count];
        self.photosFrame = (CGRect){{photosX, photosY}, photosSize};
        
        h = CGRectGetMaxY(self.photosFrame) + SWStatusCellInset;
    } else {
        h = CGRectGetMaxY(self.textFrame) + SWStatusCellInset;
    }
    
    //转发微博
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = SWScreenW;
    self.frame = CGRectMake(x, y, w, h);

}

@end
