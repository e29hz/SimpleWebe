//
//  SWStatusDetailView.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/19.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWStatusDetailView.h"
#import "SWStatusOriginalView.h"
#import "SWStatusRetweetedView.h"
#import "SWStatusDetailFrame.h"

@interface SWStatusDetailView()
@property (nonatomic, weak) SWStatusOriginalView *originalView;
@property (nonatomic, weak) SWStatusRetweetedView *retweetedView;
@end

@implementation SWStatusDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.image = [UIImage resizedImage:@"timeline_card_top_background"];
        
        //添加原创微博
        SWStatusOriginalView *originalView = [[SWStatusOriginalView alloc] init];
        [self addSubview:originalView];
        self.originalView = originalView;
        //添加转发微博
        SWStatusRetweetedView *retweetedView = [[SWStatusRetweetedView alloc] init];
        [self addSubview:retweetedView];
        self.retweetedView = retweetedView;
    }
    return self;
}

- (void)setDetailFrame:(SWStatusDetailFrame *)detailFrame
{
    _detailFrame = detailFrame;
    self.frame = detailFrame.frame;
    
    //原创微博的frame数据
    self.originalView.originalFrame = detailFrame.originalFrame;
    //转发微博的frame数据
    self.retweetedView.retweetedFrame = detailFrame.retweetedFrame;
}

@end
