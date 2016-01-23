//
//  SWComposeToolbar.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/14.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWComposeToolbar.h"

@implementation SWComposeToolbar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background_os7"]];
        
        // 添加所有的子控件
        [self addButtonWithIcon:@"compose_camerabutton_background_os7" highIcon:@"compose_camerabutton_background_highlighted_os7" tag:SWComposeToolbarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture_os7" highIcon:@"compose_toolbar_picture_highlighted_os7" tag:SWComposeToolbarButtonTypePicture];
        [self addButtonWithIcon:@"compose_mentionbutton_background_os7" highIcon:@"compose_mentionbutton_background_highlighted_os7" tag:SWComposeToolbarButtonTypeMention];
        [self addButtonWithIcon:@"compose_trendbutton_background_os7" highIcon:@"compose_trendbutton_background_highlighted_os7" tag:SWComposeToolbarButtonTypeTrend];
        [self addButtonWithIcon:@"compose_emoticonbutton_background_os7" highIcon:@"compose_emoticonbutton_background_highlighted_os7" tag:SWComposeToolbarButtonTypeEmotion];

    }
    return self;
}
/**
 *  添加按钮
 *
 *  @param icon     默认图标
 *  @param highIcon 高亮图标
 */
- (void)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(SWComposeToolbarButtonType)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    [self addSubview:button];

}
/**
 *  监听按钮点击
 */
- (void)buttonClick:(UIButton *)button
{
    SWLog(@"buttonClick-------");
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickedButton:)]) {
        [self.delegate composeToolbar:self didClickedButton:button.tag];
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    int count = (int)self.subviews.count;
    CGFloat buttonW = self.width / count;
    CGFloat buttonH = self.height;
    for (int i = 0; i < count; i++) {
        UIButton *button = self.subviews[i];
        button.y = 0;
        button.width = buttonW;
        button.height = buttonH;
        button.x = i * buttonW;
    }
}
@end
