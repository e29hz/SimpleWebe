//
//  SWStatusOriginalFrame.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/20.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SWStatus;
@interface SWStatusOriginalFrame : NSObject
/**
 *  微博数据
 */
@property (nonatomic, strong) SWStatus *status;
/**
 *  头像
 */
@property (nonatomic, assign) CGRect iconFrame;
/**
 *  昵称
 */
@property (nonatomic, assign) CGRect nameFrame;
/**
 *  会员图标
 */
@property (nonatomic, assign) CGRect vipFrame;
/**
 *  正文
 */
@property (nonatomic, assign) CGRect textFrame;
/**
 *  配图
 */
@property (nonatomic, assign) CGRect photosFrame;


/**
 *  原微博自身frame
 */
@property (nonatomic, assign) CGRect frame;

@end
