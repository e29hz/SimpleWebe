//
//  SWStatusFrame.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/20.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SWStatus, SWStatusDetailFrame;

@interface SWStatusFrame : NSObject
/**
 *  子控件frame数据
 */
@property (nonatomic, assign) CGRect toolbarFrame;
@property (nonatomic, strong) SWStatusDetailFrame *detailFrame;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/**
 *  微博数据
 */
@property (nonatomic, strong) SWStatus *status;

@end
