//
//  SWEmotionTextView.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/2/3.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWEmotionTextView.h"
#import "SWEmotion.h"
#import "SWEmotionTextAttachment.h"

@implementation SWEmotionTextView

- (void)appendEmotion:(SWEmotion *)emotion
{
    if (emotion.emoji) {// emoji表情
        
        [self insertText:emotion.emoji];
        
    } else {// 图片表情
        
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        
        //记录表情的插入位置
        int insertIndex = (int)self.selectedRange.location;
       
        //创建一个带有图片表情的富文本
        SWEmotionTextAttachment *attch = [[SWEmotionTextAttachment alloc] init];
        attch.emotion = emotion;
        attch.bounds = CGRectMake(0, -4, self.font.lineHeight, self.font.lineHeight);
        NSAttributedString *attachString = [NSMutableAttributedString  attributedStringWithAttachment:attch];
        
        // 插入表情图片到光标位置
        [attributedText insertAttributedString:attachString atIndex:self.selectedRange.location];
        
        //设置字体
        [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        
        //重新赋值
        self.attributedText = attributedText;
        
        //让光标回到表情后面的位置
        self.selectedRange = NSMakeRange(insertIndex + 1, 0);
    }
    
}


- (NSString *)realText
{
    
    NSMutableString *string = [NSMutableString string];
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        SWEmotionTextAttachment *attach = attrs[@"NSAttachment"];
        if (attach) {// 带有图片的富文本
            
            [string appendString:attach.emotion.chs];
        } else { // 普通文本
            //截取range范围内的富文本
            NSString *subStr = [self.attributedText attributedSubstringFromRange:range].string;
            [string appendString:subStr];
        }
    
    }];
    
    return string;
}


@end
