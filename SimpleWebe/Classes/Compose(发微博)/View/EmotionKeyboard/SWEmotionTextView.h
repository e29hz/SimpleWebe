//
//  SWEmotionTextView.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/2/3.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWTextView.h"
@class SWEmotion;
@interface SWEmotionTextView : SWTextView
/**
 *  拼接表情到最后
 */
- (void)appendEmotion:(SWEmotion *)emotion;

/**
 *  具体文本
 */
- (NSString *)realText;

@end
