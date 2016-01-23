//
//  SWComposeToolbar.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/14.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SWComposeToolbarButtonTypeCamera, //照相机
    SWComposeToolbarButtonTypePicture, //相册
    SWComposeToolbarButtonTypeMention, //@
    SWComposeToolbarButtonTypeTrend, //话题
    SWComposeToolbarButtonTypeEmotion, //表情
}SWComposeToolbarButtonType;

@class SWComposeToolbar;

@protocol SWComposeToolbarDelegate <NSObject>

@optional
- (void)composeToolbar:(SWComposeToolbar *)toolbar didClickedButton:(SWComposeToolbarButtonType)buttonType;

@end

@interface SWComposeToolbar : UIView

@property (nonatomic, weak) id<SWComposeToolbarDelegate> delegate;
@end
