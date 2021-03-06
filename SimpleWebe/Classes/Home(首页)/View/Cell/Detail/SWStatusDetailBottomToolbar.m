//
//  SWStatusDetailBottomToolbar.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/2/16.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWStatusDetailBottomToolbar.h"

@implementation SWStatusDetailBottomToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtnWithIcon:@"timeline_icon_retweet" title:@"转发"];
        [self setupBtnWithIcon:@"timeline_icon_comment" title:@"评论"];
        [self setupBtnWithIcon:@"timeline_icon_unlike" title:@"赞"];
    }
    return self;
}
/**
 *  添加按钮
 *
 *  @param icon  图标
 *  @param title 标题
 */
- (UIButton *)setupBtnWithIcon:(NSString *)icon title:(NSString *)title
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    // 设置间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [self addSubview:btn];
    
    return btn;
}


- (void)drawRect:(CGRect)rect {
    [[UIImage resizedImage:@"statusdetail_toolbar_background"] drawInRect:rect];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    int btnCount = (int)self.subviews.count;
    CGFloat margin = 10;
    CGFloat btnW = (self.width - (btnCount + 1) * margin) / btnCount;
    CGFloat btnY = 5;
    CGFloat btnH = self.height - 2 * btnY;
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.y = btnY;
        btn.x = margin + i * (btnW + margin);
    }
}

@end
