//
//  SWRegexResult.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/2/8.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWRegexResult : NSObject
/**
 *  匹配的字符串
 */
@property (nonatomic, copy) NSString *string;
/**
 *  匹配到的范围
 */
@property (nonatomic, assign) NSRange range;

/**
 *  结果是否为表情
 */
@property (nonatomic, assign, getter=isEmotion) BOOL emotion;
@end
