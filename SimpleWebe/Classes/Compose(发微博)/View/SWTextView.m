//
//  SWTextView.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/13.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWTextView.h"
@interface SWTextView ()<UITextViewDelegate>

@property (nonatomic, weak) UILabel *placehoderLabel;

@end

@implementation SWTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //添加提醒文字的label
        UILabel *placehoderLabel = [[UILabel alloc] init];
        placehoderLabel.numberOfLines = 0;
        placehoderLabel.backgroundColor = [UIColor clearColor];
        
        [self addSubview:placehoderLabel];
        self.placehoderLabel = placehoderLabel;
        
        //设置默认的展占位文字颜色
        self.placehoderColor = [UIColor lightGrayColor];
        
        //设置默认字体
        self.font = [UIFont systemFontOfSize:16.0f];
//        self.placehoderLabel.font = self.font;
        
        //监听内部文字改变
        //当self的文字发生改变,self就会地洞发出一个UITextFieldTextDidChangeNotification通知
        //一旦发出上面通知,就会调用self的textDidChange方法
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 监听文字改变
- (void)textDidChange
{
//    SWLog(@"textDidChange---%@", self.text);
    self.placehoderLabel.hidden = (self.text.length != 0);

}


#pragma mark - 公共方法

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placehoderLabel.font = font;
    
    //重新计算子空间的frame
    [self setNeedsLayout];
}
- (void)setPlacehoder:(NSString *)placehoder
{
    _placehoder = [placehoder copy];
    //设置文字
    self.placehoderLabel.text = placehoder;
    //重新计算子空间的frame
    [self setNeedsLayout];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.placehoderLabel.x = 5;
    self.placehoderLabel.y = 8;
    self.placehoderLabel.width = self.width - 2 * self.placehoderLabel.x;
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
    CGSize maxSize = CGSizeMake(self.placehoderLabel.width, MAXFLOAT);
    self.placehoderLabel.numberOfLines = 0;
    CGRect tmpRect = [self.placehoder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    self.placehoderLabel.height = tmpRect.size.height;
    
}

- (void)setPlacehoderColor:(UIColor *)placehoderColor
{
    _placehoderColor = placehoderColor;
    
    self.placehoderLabel.textColor = placehoderColor;
}
@end
