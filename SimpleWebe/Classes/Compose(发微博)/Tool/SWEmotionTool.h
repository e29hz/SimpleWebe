//
//  SWEmotionTool.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/2/1.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SWEmotion;

@interface SWEmotionTool : NSObject
/**
 *  默认表情
 */
+ (NSArray *)defaultEmotions;
/**
 *  emoji表情
 */
+ (NSArray *)emojiEmotions;
/**
 *  浪小花表情
 */
+ (NSArray *)lxhEmotions;
/**
 *  最近表情
 */
+ (NSArray *)recentEmotions;
/**
 *  根据表情的文字描述找出对应的表情对象
 */
+ (SWEmotion *)emotionWithDesc:(NSString *)desc;

/**
 *  保存最近使用的表情
 */
+ (void)addRecentEmotion:(SWEmotion *)emotion;
@end
