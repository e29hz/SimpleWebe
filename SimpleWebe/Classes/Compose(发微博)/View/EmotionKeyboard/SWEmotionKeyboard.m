//
//  SWEmotionKeyboard.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/28.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWEmotionKeyboard.h"
#import "SWEmotionListView.h"
#import "SWEmotionToolbar.h"
#import "SWEmotion.h"
#import "SWEmotionTool.h"


@interface SWEmotionKeyboard ()<SWEmotionToolbarDelegate>
/**
 *  表情列表
 */
@property (nonatomic, weak) SWEmotionListView *listView;
/**
 *  表情工具条
 */
@property (nonatomic, weak) UIView *toolbarView;

/** 
 *  默认表情
 */
@property (nonatomic, strong) NSArray *defaultEmotions;
/** 
 *  emoji表情 
 */
@property (nonatomic, strong) NSArray *emojiEmotions;
/** 
 *  浪小花表情 
 */
@property (nonatomic, strong) NSArray *lxhEmotions;

@end

@implementation SWEmotionKeyboard




+ (instancetype)keyboard
{
    return  [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];

        //添加表情列表
        SWEmotionListView *listView = [[SWEmotionListView alloc] init];
        [self addSubview:listView];
        self.listView = listView;
        
        
        //添加表情工具条
        SWEmotionToolbar *toolbarView = [[SWEmotionToolbar alloc] init];
        toolbarView.delegate = self;
        [self addSubview:toolbarView];
        self.toolbarView = toolbarView;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置toolView的frame
    self.toolbarView.width = self.width;
    self.toolbarView.height = 44;
    self.toolbarView.y = self.height - self.toolbarView.height;
    
    //设置listView的frame
    self.listView.width = self.width;
    self.listView.height = self.toolbarView.y;
    
}

#pragma mark - HMEmotionToolbarDelegate
- (void)emotionToolbar:(SWEmotionToolbar *)toolbar didSelectedButton:(SWEmotionType)emotionType
{
    switch (emotionType) {
        case SWEmotionTypeDefault:// 默认
            self.listView.emotions = [SWEmotionTool defaultEmotions];
            break;
            
        case SWEmotionTypeEmoji: // Emoji
            self.listView.emotions = [SWEmotionTool emojiEmotions];
            break;
            
        case SWEmotionTypeLxh: // 浪小花
            self.listView.emotions = [SWEmotionTool lxhEmotions];
            break;
            
        case SWEmotionTypeRecent: // 最近
            self.listView.emotions = [SWEmotionTool recentEmotions];
            break;
            
        default:
            break;
    }
}

@end
