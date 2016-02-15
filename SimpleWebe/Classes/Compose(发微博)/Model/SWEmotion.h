//
//  SWEmotion.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/28.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWEmotion : NSObject <NSCoding>
/**
 *  表情的文字简体描述
 */
@property (nonatomic, copy) NSString *chs;
/**
 *  表情的文字繁体描述
 */
@property (nonatomic, copy) NSString *cht;
/** 
 *  表情的文png图片名
 */
@property (nonatomic, copy) NSString *png;
/** 
 *  emoji表情的编码 
 */
@property (nonatomic, copy) NSString *code;


/**
 *  表情存放文件夹
 */
@property (nonatomic, copy) NSString *directory;
/**
 *  emoji表情的字符
 */
@property (nonatomic, copy) NSString *emoji;
@end
