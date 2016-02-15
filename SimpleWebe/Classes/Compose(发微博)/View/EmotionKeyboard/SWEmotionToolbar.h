//
//  SWEmotionToolbar.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/28.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWEmotionToolbar;

typedef enum {
    SWEmotionTypeRecent, // 最近
    SWEmotionTypeDefault, // 默认
    SWEmotionTypeEmoji, // Emoji
    SWEmotionTypeLxh // 浪小花
} SWEmotionType;

@protocol SWEmotionToolbarDelegate <NSObject>

@optional
- (void)emotionToolbar:(SWEmotionToolbar *)toolbar didSelectedButton:(SWEmotionType)emotionType;
@end

@interface SWEmotionToolbar : UIView
@property (nonatomic, weak) id<SWEmotionToolbarDelegate> delegate;
@end
