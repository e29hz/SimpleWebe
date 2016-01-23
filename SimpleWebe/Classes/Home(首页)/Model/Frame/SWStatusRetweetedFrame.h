//
//  SWStatusRetweetedFrame.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/20.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SWStatus;

@interface SWStatusRetweetedFrame : NSObject
/**
 *  转发微博数据
 */
@property (nonatomic, strong) SWStatus *retweetedStatus;

@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) CGRect nameFrame;
@property (nonatomic, assign) CGRect textFrame;
@end
