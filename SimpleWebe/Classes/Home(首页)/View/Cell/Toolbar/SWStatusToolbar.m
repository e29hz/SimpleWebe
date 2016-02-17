//
//  SWStatusToolbar.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/19.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWStatusToolbar.h"

@interface SWStatusToolbar ()

@property (nonatomic, strong) NSMutableArray *dividers;

@end

@implementation SWStatusToolbar
- (NSMutableArray *)dividers
{
    if (_dividers == nil) {
        self.dividers = [NSMutableArray array];
    }
    return _dividers;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

/**
 *  分割线
 */
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    divider.contentMode = UIViewContentModeCenter;
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int dividerCount = (int)self.dividers.count;
    CGFloat dividerFirstX = self.width / (dividerCount + 1);
    CGFloat dividerH = self.height;
    
    // 设置分割线的frame
    for (int i = 0; i<dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 4;
        divider.height = dividerH;
        divider.centerX = (i + 1) * dividerFirstX;
        divider.centerY = dividerH * 0.5;
    }
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage resizedImage:@"common_card_bottom_background"] drawInRect:rect];
}

@end
