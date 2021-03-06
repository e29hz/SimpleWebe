//
//  SWEmotionPopView.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/31.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWEmotionPopView.h"
#import "SWEmotionView.h"

@interface SWEmotionPopView ()
@property (weak, nonatomic) IBOutlet SWEmotionView *emotionView;

@end

@implementation SWEmotionPopView


+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SWEmotionPopView" owner:nil options:nil] firstObject];
}

- (void)showFromEmotionView:(SWEmotionView *)fromEmotionView
{
    if (fromEmotionView == nil) {
        return;
    }
    //显示表情
    self.emotionView.emotion = fromEmotionView.emotion;

    //添加到窗口上
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    //设置位置
    CGFloat centerX = fromEmotionView.centerX;
    CGFloat centerY = fromEmotionView.centerY - self.height * 0.5;
    CGPoint center = CGPointMake(centerX, centerY);
    self.center = [window convertPoint:center fromView:fromEmotionView.superview];

}

- (void)dismissEmotionView
{
    [self removeFromSuperview];
}

/**
 *  当一个控件显示之前会调用一次,如果控件显示之前没有尺寸,则不会调用该方法
 *
 *  @param rect 控件的bounds
 */
- (void)drawRect:(CGRect)rect {
    
    [[UIImage imageNamed:@"emoticon_keyboard_magnifier"] drawInRect:rect];
    
}


@end
