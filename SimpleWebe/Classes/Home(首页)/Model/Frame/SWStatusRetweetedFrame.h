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
/**
 *  转发微博frame
 */
@property (nonatomic, assign) CGRect frame;
/**
 *  昵称
 */
@property (nonatomic, assign) CGRect nameFrame;
/**
 *  正文
 */
@property (nonatomic, assign) CGRect textFrame;
/**
 *  配图
 */
@property (nonatomic, assign) CGRect photosFrame;
/**
 *  工具条
 */
@property (nonatomic, assign) CGRect toolbarFrame;
@end
