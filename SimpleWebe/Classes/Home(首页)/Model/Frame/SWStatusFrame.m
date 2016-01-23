//
//  SWStatusFrame.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/20.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWStatusFrame.h"
#import "SWStatus.h"
#import "SWStatusDetailFrame.h"

@implementation SWStatusFrame

- (void)setStatus:(SWStatus *)status
{
    _status = status;

    //计算微博具体内容
    [self setupDetailFrame];
    //计算底部工具条
    [self setupToolbarFrame];
    //计算cell高度
    self.cellHeight = CGRectGetMaxY(self.toolbarFrame);
}

/**
 *  计算微博具体内容
 */
- (void)setupDetailFrame
{
    SWStatusDetailFrame *detailFrame = [[SWStatusDetailFrame alloc] init];
    detailFrame.status = self.status;
    self.detailFrame = detailFrame;
    
}
/**
 *  计算底部工具条
 */
- (void)setupToolbarFrame
{
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(self.detailFrame.frame);
    CGFloat toolbarW = SWScreenW;
    CGFloat toolbarH = 35;
    self.toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
}

@end
