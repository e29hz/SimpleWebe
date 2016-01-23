//
//  SWStatusDetailFrame.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/20.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SWStatusOriginalFrame, SWStatusRetweetedFrame, SWStatus;

@interface SWStatusDetailFrame : NSObject

@property (nonatomic, strong) SWStatusOriginalFrame *originalFrame;

@property (nonatomic, strong) SWStatusRetweetedFrame *retweetedFrame;
/**
 *  微博数据
 */
@property (nonatomic, strong) SWStatus *status;

@property (nonatomic, assign) CGRect frame;


@end





