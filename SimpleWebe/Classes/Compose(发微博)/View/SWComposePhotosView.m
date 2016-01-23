//
//  SWComposePhotosView.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/14.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWComposePhotosView.h"

@implementation SWComposePhotosView



- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.image = image;
    [self addSubview:imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    int count = (int)self.subviews.count;
    //每一行的最大列数
    int maxColumnsPerRow = 4;
    //每个图片之间的间距
    CGFloat margin = 10;
    //每个图片的宽高
    CGFloat imageViewW = (self.width - (maxColumnsPerRow + 1) * margin) / maxColumnsPerRow;
    CGFloat imageViewH = imageViewW;
    
    for (int i = 0; i < count; i++) {
        //行号
        int row = i / maxColumnsPerRow;
        //列号
        int col =i % maxColumnsPerRow;
        
        UIImageView *imageView = self.subviews[i];
        imageView.width = imageViewW;
        imageView.height = imageViewH;
        imageView.x = col * (imageViewW + margin) + margin;
        imageView.y = row * (imageViewH + margin);
    }
}

- (NSArray *)images
{
    NSMutableArray *array = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [array  addObject:imageView.image];
    }
    return array;
}

@end
