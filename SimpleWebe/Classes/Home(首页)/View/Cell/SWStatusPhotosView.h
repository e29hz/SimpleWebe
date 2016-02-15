//
//  SWStatusPhotosView.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/24.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWStatusPhotosView : UIView
/**
 *  图片数据(SWPhoto)
 */
@property (nonatomic, strong) NSArray *pic_urls;
/**
 *  根据图片个数计算相册的最终尺寸
 */
+ (CGSize)sizeWithPhotosCount:(int)photosCount;

@end
