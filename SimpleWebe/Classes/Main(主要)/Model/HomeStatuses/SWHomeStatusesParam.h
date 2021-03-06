//
//  SWHomeStatusesParam.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/17.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWBaseParam.h"

@interface SWHomeStatusesParam : SWBaseParam

/**
 *  采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得
 */
@property (nonatomic, strong) NSNumber *since_id;
/**
 *  若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
 */
@property (nonatomic, strong) NSNumber *max_id;

/** 
 *  单页返回的记录条数，最大不超过100，默认为20
 */
@property (nonatomic, strong) NSNumber *count;
@end
