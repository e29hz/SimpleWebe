//
//  SWStatusLabel.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/2/13.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWStatusLabel.h"
#import "SWCellLink.h"

#define SWLinkBackgroundTag 10000
@interface SWStatusLabel ()

@property (nonatomic, weak) UITextView *textView;

@property (nonatomic, strong) NSMutableArray *links;

@end

@implementation SWStatusLabel

-(NSMutableArray *)links
{
    if (!_links) {
        NSMutableArray *links = [NSMutableArray array];
        //搜索所有链接
        
        [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
            NSString *linkText = attrs[SWLink];
            if (linkText == nil) {
                return ;
            }
            //创建一个链接
            SWCellLink *link = [[SWCellLink alloc] init];
            
            link.text = linkText;
            link.range = range;

            //处理矩形框
            NSMutableArray *rects = [NSMutableArray array];
            
            
            //设置选中的字符范围
            self.textView.selectedRange = range;
            
            //算出选中的字符范围的边框
            NSArray *selectionRects = [self.textView selectionRectsForRange:self.textView.selectedTextRange];
            for (UITextSelectionRect *selectionRect in selectionRects) {
                if (selectionRect.rect.size.width == 0 || selectionRect.rect.size.height == 0) {
                    continue;
                }
                [rects addObject:selectionRect];
                
                link.rects = rects;
                
                [links addObject:link];
                
            }
            
        }];
        
        self.links = links;
    }
    return _links;
}

/**
 0.查找出所有的链接（用一个数组存放所有的链接）
 
 1.在touchesBegan方法中，根据触摸点找出被点击的链接
 
 2.在被点击链接的边框范围内添加一个有颜色的背景
 
 3.在touchesEnded或者touchedCancelled方法中，移除所有的链接背景
 */

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        self.backgroundColor = [UIColor redColor];
        
        UITextView *textView = [[UITextView alloc] init];
        //不能编辑
        textView.editable = NO;
        //不能滚动
        textView.scrollEnabled = NO;
        //不能和用户交互
        textView.userInteractionEnabled = NO;
        textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        textView.backgroundColor = [UIColor clearColor];
        [self addSubview:textView];
        self.textView = textView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textView.frame = self.bounds;
    
}

#pragma mark - 公共接口
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    _attributedText = attributedText;
    
    self.textView.attributedText = attributedText;
    self.links = nil;
}

#pragma mark - 事件处理
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    //找到被点击的那个链接
    SWCellLink *touchingLink = [self touchingLinkWithPoint:point];
    
    //设置链接选中背景
    [self showLinkBackground:touchingLink];
    
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeAllLinkBackground];

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    //找到被点击的那个链接
    SWCellLink *touchingLink = [self touchingLinkWithPoint:point];
    if (touchingLink) {
        //说明手指还在某个连接上
        [[NSNotificationCenter defaultCenter] postNotificationName:SWLinkDidSelectedNotification object:nil userInfo:@{SWLink : touchingLink.text}];
    }
    [self removeAllLinkBackground];
}

#pragma mark - 链接背景处理

/**
 *  根据触摸点,找到被点击的那个链接
 */
- (SWCellLink *)touchingLinkWithPoint :(CGPoint)point
{
    __block SWCellLink *touchingLink = nil;
    [self.links enumerateObjectsUsingBlock:^(SWCellLink *link, NSUInteger idx, BOOL * _Nonnull stop) {
        for (UITextSelectionRect *selectionRect in link.rects) {
            if (CGRectContainsPoint(selectionRect.rect, point)) {
                touchingLink = link;
                break;
            }
        }
    }];
    return touchingLink;
}

/**
 *  显示链接的背景
 *
 *  @param link 需要现实背景的链接
 */
- (void)showLinkBackground:(SWCellLink *)link
{
    for (UITextSelectionRect *selectionRect in link.rects) {
        //添加背景到选中字符上
        UIView *bg = [[UIView alloc] init];
        bg.tag = SWLinkBackgroundTag;
        bg.layer.cornerRadius = 3;
        bg.frame = selectionRect.rect;
        bg.backgroundColor = SWColor(190, 223, 254);
        [self insertSubview:bg atIndex:0];
    }
}


- (void)removeAllLinkBackground
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (UIView *child in self.subviews) {
            if (child.tag == SWLinkBackgroundTag) {
                [child removeFromSuperview];
            }
        }
    });
    
}
/**
 *  这个方法会返回能够处理时间的控件
 *
 *  @param point 触摸点
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if([self touchingLinkWithPoint:point])
    {
        return self;
    }
    return nil;

}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
//    if([self touchingLinkWithPoint:point])
//    {
//        return YES;
//    }
//    return NO;
//}
@end
