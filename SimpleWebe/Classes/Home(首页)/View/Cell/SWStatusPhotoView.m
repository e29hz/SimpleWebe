//
//  SWStatusPhotoView.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/24.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWStatusPhotoView.h"
#import "SWPhoto.h"
#import "UIImageView+WebCache.h"

@interface SWStatusPhotoView()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation SWStatusPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        //添加gif图标
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return self;
}

- (void)setPhoto:(SWPhoto *)photo
{
    _photo = photo;
    //下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    //控制gif图片的显示
    NSString *extension = photo.thumbnail_pic.pathExtension.lowercaseString;
    self.gifView.hidden = ![extension isEqualToString:@"gif"];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}
@end
