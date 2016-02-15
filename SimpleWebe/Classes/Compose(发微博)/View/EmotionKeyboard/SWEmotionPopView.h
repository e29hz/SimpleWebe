//
//  SWEmotionPopView.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/31.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWEmotion, SWEmotionView;

@interface SWEmotionPopView : UIView

+ (instancetype)popView;
/**
 *  显示表情弹出控件
 *
 *  @param emotionView 从哪个表情上弹出
 */
- (void)showFromEmotionView:(SWEmotionView *)fromEmotionView;
- (void)dismissEmotionView;

@end
