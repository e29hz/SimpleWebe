//
//  SWStatusOriginalFrame.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/20.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWStatusOriginalFrame.h"
#import "SWStatus.h"
#import "SWUser.h"


@implementation SWStatusOriginalFrame

- (void)setStatus:(SWStatus *)status
{
    _status = status;
    //头像
    CGFloat iconX = SWStatusCellInset;
    CGFloat iconY = SWStatusCellInset;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + SWStatusCellInset;
    CGFloat nameY = iconY;
    CGSize nameSize = [status.user.name sizeWithAttributes:SWStatusOriginalNameFontAttribute];
//    self.iconFrame = CGRectMake(nameX, nameY, iconW, iconH);
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    if(status.user.vip)
    {
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + SWStatusCellInset * 0.5;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = vipH;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    

    
    //正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + SWStatusCellInset;
    CGFloat maxW = SWScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [status.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:SWStatusOriginalTextFontAttribute context:nil].size;
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    //原创微博
    CGFloat x = 0;
        CGFloat y = 0;
        CGFloat w = SWScreenW;
        CGFloat h = CGRectGetMaxY(self.textFrame) + SWStatusCellInset;
    self.frame = CGRectMake(x, y, w, h);
}

@end
