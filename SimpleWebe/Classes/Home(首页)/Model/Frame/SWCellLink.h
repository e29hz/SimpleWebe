//
//  SWCellLink.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/2/15.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWCellLink : NSObject
/**
 *  链接的文字
 */
@property (nonatomic, copy) NSString *text;
/**
 *  链接的范围
 */
@property (nonatomic, assign) NSRange range;
/**
 *  链接的边框
 */
@property (nonatomic, strong) NSArray *rects;

@end
