//
//  SWStatusPhotosView.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/24.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWStatusPhotosView.h"
#import "SWStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "SWPhoto.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define SWStatusPhotosMaxCount 9
//一行最多多少列
#define SWStatusPhotosMaxCols(photosCount) ((photosCount==4)?2:3)
#define SWStatusPhotoW (SWScreenW - (2 * (SWStatusCellInset + SWStatusPhotoMargin))) / 3
#define SWStatusPhotoH SWStatusPhotoW
#define SWStatusPhotoMargin 5

@interface SWStatusPhotosView ()

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, assign) CGRect lastFrame;

@end

@implementation SWStatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //预先创建9个图片控件
        for (int i = 0; i < SWStatusPhotosMaxCount; i++) {
            SWStatusPhotoView *photoView = [[SWStatusPhotoView alloc] init];
            photoView.tag = i;
            [self addSubview:photoView];
            
            //添加手势监听器(一个手势监听器 只能 监听一个对应的view)
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
            [recognizer addTarget:self action:@selector(tapPhoto:)];
            [photoView addGestureRecognizer:recognizer];
        }
        
    }
    return self;
}
/**
 *  监听图片的点击
 */
- (void)tapPhoto:(UITapGestureRecognizer *)recognizer
{
    //创建图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    //设置图片浏览器现实的所有图片
    NSMutableArray *photos = [NSMutableArray array];
    int count = (int)self.pic_urls.count;
    for (int i = 0; i < count; i++) {
        SWPhoto *pic = self.pic_urls[i];
        
        MJPhoto  *photo = [[MJPhoto alloc] init];
        //设置图片路径
        photo.url = [NSURL URLWithString:pic.bmiddle_pic];
        //设置来源于哪个UIImageView
        photo.srcImageView = self.subviews[i];
        [photos addObject:photo];
    }
    
    browser.photos = photos;
    
    //设置默认显示的图片索引
    browser.currentPhotoIndex = recognizer.view.tag;
    
    //显示浏览器
    [browser show];
}

- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    for (int i = 0; i < SWStatusPhotosMaxCount; i++) {
        SWStatusPhotoView *photoView = self.subviews[i];
        if (i < pic_urls.count) {
            photoView.photo = pic_urls[i];
            photoView.hidden = NO;
        } else {
            photoView.hidden = YES;
        }

    }
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    int count = (int)self.pic_urls.count;
    int maxCols = SWStatusPhotosMaxCols(count);
    for (int i = 0; i < count; i++) {
        SWStatusPhotoView *photoView = self.subviews[i];
        photoView.x = (i % maxCols) * (SWStatusPhotoW + SWStatusPhotoMargin);
        photoView.y = (i / maxCols) * (SWStatusPhotoH + SWStatusPhotoMargin);
        if (count == 1) {
            photoView.width = (SWScreenW - (2 * SWStatusCellInset)) / 2;
            photoView.height = photoView.width;
        } else{
            photoView.width = SWStatusPhotoW;
            photoView.height = SWStatusPhotoH;
            
        }

    }
}

+ (CGSize)sizeWithPhotosCount:(int)photoCount
{
    int maxCols = SWStatusPhotosMaxCols(photoCount);

    
    //总列数
    int totalCols = (int)(photoCount >= maxCols ? maxCols : photoCount);
    //总行数
    int totalRows = (int)(photoCount + maxCols - 1) / maxCols;
    
    //        SWScreenW - 2 * SWStatusPhotoMargin / maxCols * totalCols
    CGFloat photosW;
    CGFloat photosH;
    if (photoCount == 1) {
        photosW = (SWScreenW - (2 * SWStatusCellInset)) / 2;
        photosH = photosW;
    } else {
        photosW = totalCols * SWStatusPhotoW + (totalCols - 1) * SWStatusPhotoMargin;
        photosH = totalRows * SWStatusPhotoH + (totalRows - 1) * SWStatusPhotoMargin;
    }
    return CGSizeMake(photosW, photosH);

}

@end
