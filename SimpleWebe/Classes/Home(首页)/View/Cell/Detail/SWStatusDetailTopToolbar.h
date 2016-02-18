//
//  SWStatusDetailTopToolbar.h
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/2/16.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SWStatusDetailTopToolbarButtonTypeRetweeted,
    SWStatusDetailTopToolbarButtonTypeComment,
} SWStatusDetailTopToolbarButtonType;

@class SWStatusDetailTopToolbar, SWStatus;

@protocol SWStatusDetailTopToolbarDelegate <NSObject>

@optional
- (void)topToolbar:(SWStatusDetailTopToolbar *)topToolbar didSelectedButton:(SWStatusDetailTopToolbarButtonType)buttonType;
@end

@interface SWStatusDetailTopToolbar : UIView
+ (instancetype)toolbar;


@property (nonatomic, weak) id<SWStatusDetailTopToolbarDelegate> delegate;
@property (nonatomic, assign) SWStatus *status;

@property (nonatomic, assign) SWStatusDetailTopToolbarButtonType selectedButtonType;

@end
