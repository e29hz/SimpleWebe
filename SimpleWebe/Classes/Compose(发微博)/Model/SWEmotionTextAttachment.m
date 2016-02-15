//
//  SWEmotionTextAttachment.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/2/8.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWEmotionTextAttachment.h"
#import "SWEmotion.h"

@implementation SWEmotionTextAttachment

- (void)setEmotion:(SWEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png]];

}

@end
