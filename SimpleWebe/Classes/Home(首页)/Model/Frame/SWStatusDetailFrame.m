//
//  SWStatusDetailFrame.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/20.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWStatusDetailFrame.h"
#import "SWStatus.h"
#import "SWStatusOriginalFrame.h"
#import "SWStatusRetweetedFrame.h"

@implementation SWStatusDetailFrame

- (void)setStatus:(SWStatus *)status
{
    _status = status;
    
    //原创微博的frame
    SWStatusOriginalFrame *originalFrame = [[SWStatusOriginalFrame alloc] init];
    originalFrame.status = status;
    self.originalFrame = originalFrame;
    
    
    //转发微博的frame
    
    CGFloat h = 0;
    if (status.retweeted_status) {
        
        SWStatusRetweetedFrame *retweetedFrame = [[SWStatusRetweetedFrame alloc] init];
        retweetedFrame.retweetedStatus = status.retweeted_status;
        //计算转发微博frame的y值
        CGRect f = retweetedFrame.frame;
        f.origin.y = CGRectGetMaxY(originalFrame.frame);
        retweetedFrame.frame = f;
        self.retweetedFrame = retweetedFrame;
        
        h = CGRectGetMaxY(retweetedFrame.frame);
    } else {
        h = CGRectGetMaxY(originalFrame.frame);
    }
    
    //detail的frame
    CGFloat x = 0;
    CGFloat y = SWStatusCellMargin;
    CGFloat w = SWScreenW;
    
    self.frame = CGRectMake(x, y, w, h);
    
}

@end
