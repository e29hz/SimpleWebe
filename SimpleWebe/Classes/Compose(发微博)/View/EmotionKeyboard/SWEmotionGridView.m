//
//  SWEmotionGridView.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/30.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWEmotionGridView.h"
#import "SWEmotion.h"
#import "SWEmotionView.h"
#import "SWEmotionPopView.h"
#import "SWEmotionTool.h"

@interface SWEmotionGridView ()

@property (nonatomic, weak) UIButton *deleteButton;
@property (nonatomic, strong) NSMutableArray *emotionViews;
@property (nonatomic, strong) SWEmotionPopView *popView;

@end

@implementation SWEmotionGridView

- (SWEmotionPopView *)popView
{
    if (!_popView) {
        self.popView = [SWEmotionPopView popView];
    }
    return _popView;
}

- (NSMutableArray *)emotionViews
{
    if (!_emotionViews) {
        self.emotionViews = [NSMutableArray array];
    }
    return _emotionViews;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加删除按钮
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
                [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
        
        //添加一个长按手势识别器
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] init];
        [recognizer addTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:recognizer];
    }
    return self;
}



- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    //添加新数据
    int count = (int)emotions.count;
    int currentEmotionViewCount = (int)self.emotionViews.count;
    for (int i = 0; i < count; i++) {
        SWEmotionView *emotionView = nil;
        if (i >= currentEmotionViewCount) {//emotionView不够用
            emotionView = [[SWEmotionView alloc] init];
            [emotionView addTarget:self action:@selector(emotionClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:emotionView];
            [self.emotionViews addObject:emotionView];
        } else {//emotionView够用
            emotionView = self.emotionViews[i];
            
        }
        //传递模型数据
        emotionView.emotion = emotions[i];
        emotionView.hidden = NO;
    }
    //隐藏多余的emotionView
    for (int i = count; i < currentEmotionViewCount; i++) {
        SWEmotionView *emotionView = self.emotionViews[i];
        emotionView.hidden = YES;
    }
}

/**
 *  根据触摸点返回对应的表情控件
 */
- (SWEmotionView *)emotionViewWithPoint:(CGPoint)point
{
    __block SWEmotionView *foundEmotionView = nil;
    [self.emotionViews enumerateObjectsUsingBlock:^(SWEmotionView *emotionView, NSUInteger idx, BOOL *stop) {
        if (CGRectContainsPoint(emotionView.frame, point) && emotionView.hidden == NO) {
            foundEmotionView = emotionView;
            // 停止遍历
            *stop = YES;
        }
    }];
    return foundEmotionView;
}

/**
 *  监听长按手势
 */
- (void)longPress:(UILongPressGestureRecognizer *)recognizer
{
    //捕获触摸点
    CGPoint point = [recognizer locationInView:recognizer.view];
    //检测触摸点落在那个表情上
    SWEmotionView *emotionView = [self emotionViewWithPoint:point];
    
    if(recognizer.state == UIGestureRecognizerStateEnded) { //手松开了
        
        [self.popView dismissEmotionView];
        
        //选中表情
        [self selecteEmotion:emotionView.emotion];
        
    } else {// 手没松开
        [self.popView showFromEmotionView:emotionView];

    }
}


/**
 *  监听表情的点击
 */
- (void)emotionClick:(SWEmotionView *)emotionView
{
    [self.popView showFromEmotionView:emotionView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView dismissEmotionView];
        
        // 选中表情
        [self selecteEmotion:emotionView.emotion];
    });
    
    
}

/**
 *  选中表情
 */
- (void)selecteEmotion:(SWEmotion *)emotion
{
    if (emotion == nil) {
        return;
    }
    
    //保存使用记录
    [SWEmotionTool addRecentEmotion:emotion];
    // 发出一个选中表情的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:SWEmotionDidSelectedNotification object:nil userInfo:@{SWSelectedEmotion : emotion}];
    

}
/**
 *  点击删除按钮
 */
- (void)deleteClick
{
    // 发出一个删除表情的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:SWEmotionDidDeletedNotification object:nil userInfo:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftInset = 10;
    CGFloat topInset = 10;
    
    //排列所有表情
    CGFloat emotionViewW = (self.width - 2 * leftInset) / SWEmotionMaxCols;
    CGFloat emotionViewH = (self.height - topInset) / SWEmotionMaxRows;
    int count = (int)self.emotionViews.count;
    for (int i = 0; i < count; i++) {
        UIButton *emotionView = self.emotionViews[i];
        emotionView.x = leftInset + (i % SWEmotionMaxCols) * emotionViewW;
        emotionView.y = topInset + (i / SWEmotionMaxCols) * emotionViewH;
        emotionView.width = emotionViewW;
        emotionView.height = emotionViewH;
    }
    
    //删除按钮
    self.deleteButton.width = emotionViewW;
    self.deleteButton.height = emotionViewH;
    self.deleteButton.x = self.width - leftInset -self.deleteButton.width;
    self.deleteButton.y = topInset + (SWEmotionMaxRows - 1) *emotionViewH;
}

@end
