//
//  SWStatus.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/12.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWStatus.h"
#import "MJExtension.h"
#import "SWPhoto.h"
#import "NSDate+Extension.h"
#import "SWRegexResult.h"
#import "SWEmotionTextAttachment.h"
#import "SWEmotionTool.h"
#import "SWUser.h"
#import <RegexKitLite.h>

@implementation SWStatus

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"pic_urls" : [SWPhoto class]};
}

- (NSString *)created_at
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    [formatter setLocale:locale];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    // 获得微博发布的具体时间
    NSDate *createDate = [formatter dateFromString:_created_at];
    //是否是今年
    if (createDate.isThisYear) {
        if (createDate.isToday) {
            //今天
            NSDateComponents *components = [createDate deltaWithNow];
            if (components.hour >= 1) { //至少是一小时前发的
                return [NSString stringWithFormat:@"%d小时前", (int)components.hour];
            } else if (components.minute >= 1) { //1 - 59分
                return [NSString stringWithFormat:@"%d分钟前", (int)components.minute];
            } else { // 1分内
                return @"刚刚";
            }
            
        } else if (createDate.isYesterday) {
            [formatter setDateFormat:@"昨天 HH:mm"];
            return [formatter stringFromDate:createDate];
        } else {
            [formatter setDateFormat:@"MM-dd"];
            return [formatter stringFromDate:createDate];
        }
    } else{
        //非今年
        [formatter setDateFormat:@"yyyy-MM-dd"];
        return [formatter stringFromDate:createDate];
    }
    return nil;
}

/**
 *  根据字符串计算出所有匹配结果
 */
- (NSArray *)regexResultWithText:(NSString *)text
{
    //用来存放所有的匹配结果
    NSMutableArray *regexResults = [NSMutableArray array];
    
    
    //匹配表情
    NSString *emotionRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    [text enumerateStringsMatchedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        // 拼接图片附件
        SWRegexResult *regexResult = [[SWRegexResult alloc] init];
        regexResult.string = *capturedStrings;
        regexResult.range = *capturedRanges;
        regexResult.emotion = YES;
        [regexResults addObject:regexResult];
        
    }];
    
    [text enumerateStringsSeparatedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        //拼接普通文本
        SWRegexResult *regexResult = [[SWRegexResult alloc] init];
        regexResult.string = *capturedStrings;
        regexResult.range = *capturedRanges;
        regexResult.emotion = NO;
        [regexResults addObject:regexResult];
        
        
    }];
    
    //排序
    [regexResults sortUsingComparator:^NSComparisonResult(SWRegexResult *regexResult1, SWRegexResult *regexResult2) {
        
        int loc1 = (int)regexResult1.range.location;
        int loc2 = (int)regexResult2.range.location;
        
        return [@(loc1) compare:@(loc2)];
        
        //        if (loc1 < loc2) {
        //            return NSOrderedAscending; //升序(右边大)
        //        } else if (loc1 > loc2) {
        //            return NSOrderedDescending; //降序(右边小)
        //        } else {
        //            return NSOrderedSame;
        //        }
    }];

    return regexResults;
}

- (void)setText:(NSString *)text
{
    _text = [text copy];
    
    [self createAttributedText];
}

- (void)setUser:(SWUser *)user
{
    _user = user;
    
    [self createAttributedText];
}

- (void)setRetweeted_status:(SWStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    
    self.retweeted = NO;
    retweeted_status.retweeted = YES;
    
}

- (void)setRetweeted:(BOOL)retweeted
{
    _retweeted = retweeted;
    
    [self createAttributedText];

}

- (void)createAttributedText
{
    if (self.user == nil || self.user == nil) {
        return;
    }
    
    if (self.retweeted) {
        NSString *totalText = [NSString stringWithFormat:@"@%@ :%@", self.user.name, self.text];
        NSAttributedString *attributedString = [self attributedStringWithText:totalText];
        self.attributedText = attributedString;
    } else {
        NSAttributedString *attributedString = [self attributedStringWithText:self.text];
        self.attributedText = attributedString;
    }
}

- (NSAttributedString *)attributedStringWithText:(NSString *)text
{
    //匹配字符串
    NSArray *regexResults = [self regexResultWithText:text];
    
    //根据匹配结果,拼接对应的图片表情和普通文本
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    //遍历
    [regexResults enumerateObjectsUsingBlock:^(SWRegexResult *regexResult, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SWEmotion *emotion = nil;
        if (regexResult.isEmotion) {
            emotion = [SWEmotionTool emotionWithDesc:regexResult.string];
        }
        
        if (emotion) {
            // 创建附件对象
            SWEmotionTextAttachment *attach = [[SWEmotionTextAttachment alloc] init];
            
            //传递表情
            attach.emotion = emotion;
            attach.bounds = CGRectMake(0, -4, SWStatusOrginalTextFont.lineHeight, SWStatusOrginalTextFont.lineHeight);
            
            //将附件包装成富文本
            NSAttributedString *subStr = [NSAttributedString attributedStringWithAttachment:attach];
            [attributedString appendAttributedString:subStr];
            
        } else {// 非表情(直接拼接普通文本)
            NSMutableAttributedString *subStr = [[NSMutableAttributedString alloc] initWithString:regexResult.string];
            
            // 匹配#话题#
            
            NSString *trendRegex = @"#[a-zA-Z0-9\\u4e00-\\u9fa5]+#";
            [regexResult.string enumerateStringsMatchedByRegex:trendRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [subStr addAttribute:NSForegroundColorAttributeName value:SWStatusHighTextColor range:*capturedRanges];
                [subStr addAttribute:SWLink value:*capturedStrings range:*capturedRanges];

            }];
            
            //匹配@某人 
            NSString *mentionRegex = @"@[a-zA-Z0-9\\u4e00-\\u9fa5\\-\\_]+ ?";
            [regexResult.string enumerateStringsMatchedByRegex:mentionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [subStr addAttribute:NSForegroundColorAttributeName value:SWStatusHighTextColor range:*capturedRanges];
                [subStr addAttribute:SWLink value:*capturedStrings range:*capturedRanges];

            }];
            
            // 匹配超链接
            NSString *httpRegex = @"http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?";
            [regexResult.string enumerateStringsMatchedByRegex:httpRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [subStr addAttribute:NSForegroundColorAttributeName value:SWStatusHighTextColor range:*capturedRanges];
                [subStr addAttribute:SWLink value:*capturedStrings range:*capturedRanges];
            }];
            
            [attributedString appendAttributedString:subStr];
        }
    }];
    
    //设置富文本字体
    [attributedString addAttribute:NSFontAttributeName value:SWStatusRichTextFont range:NSMakeRange(0, attributedString.length)];
    
    return attributedString;

}

- (void)setSource:(NSString *)source
{
    // 截取范围
    if (source.length != 0) {
        NSRange range = NSMakeRange(0, 0);
        range.location = [source rangeOfString:@">"].location + 1;
        range.length = [source rangeOfString:@"</"].location - range.location;
        NSString *subSource = [source substringWithRange:range];
        
        _source = [NSString stringWithFormat:@"来自 %@", subSource];
    }
}

@end
