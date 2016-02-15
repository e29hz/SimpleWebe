//
//  SWEmotionView.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/30.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWEmotionView.h"
#import "SWEmotion.h"

@implementation SWEmotionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}


- (void)setEmotion:(SWEmotion *)emotion
{
    _emotion = emotion;
    
    if (emotion.code) { // emoji表情
        [UIView setAnimationsEnabled:NO];
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        [self setTitle:emotion.emoji forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView setAnimationsEnabled:YES];
        });
        
    } else {//图片表情
        NSString *iconPath = [NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png];
        UIImage *iconImage = [UIImage imageNamed:iconPath];
        iconImage = [iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self setImage:iconImage forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        
    }
}



@end
