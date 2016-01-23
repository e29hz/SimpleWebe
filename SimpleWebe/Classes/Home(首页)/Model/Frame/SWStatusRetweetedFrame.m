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

@implementation SWStatusRetweetedFrame

- (void)setRetweetedStatus:(SWStatus *)retweetedStatus
{
    _retweetedStatus = retweetedStatus;
    
    //昵称
    CGFloat nameX = SWStatusCellInset;
    CGFloat nameY = SWStatusCellInset;
    NSString *name = [NSString stringWithFormat:@"@%@", retweetedStatus.user.name];
    CGSize nameSize = [name sizeWithAttributes:SWStatusRetweetedNameFontAttribute];
    //    self.iconFrame = CGRectMake(nameX, nameY, iconW, iconH);
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};

    //正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameFrame) + SWStatusCellInset * 0.5;
    CGFloat maxW = SWScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [retweetedStatus.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:SWStatusRetweetedTextFontAttribute context:nil].size;
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    //转发微博
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = SWScreenW;
    CGFloat h = CGRectGetMaxY(self.textFrame) + SWStatusCellInset;
    self.frame = CGRectMake(x, y, w, h);

}

@end
