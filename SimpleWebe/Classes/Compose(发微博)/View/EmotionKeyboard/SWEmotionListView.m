//
//  SWEmotionListView.m
//  SimpleWebe
//
//  Created by 鄂鸿桢 on 16/1/28.
//  Copyright © 2016年 ehongzhen. All rights reserved.
//

#import "SWEmotionListView.h"
#import "SWEmotionGridView.h"



@interface SWEmotionListView()<UIScrollViewDelegate>
/** 
 *  显示所有表情的UIScrollView
 */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 
 *  显示页码的UIPageControl
 */
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation SWEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 显示所有表情的UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        //滚动条是UIScrollView的子控件
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 显示页码的UIPageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.hidesForSinglePage = YES;
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"_currentPageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"_pageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    // 设置总页数
    int totalPages = (int)((emotions.count + SWEmotionMaxCountPerPage - 1) / SWEmotionMaxCountPerPage);
    int currentGridViewCount = (int)self.scrollView.subviews.count;
    self.pageControl.numberOfPages = totalPages;
    self.pageControl.currentPage = 0;
    self.pageControl.hidden = totalPages <= 1;
    
    //决定UIScrollView闲时多少页表情
    for (int i = 0; i < totalPages; i++) {
        
        //获得i位置对应的SWEmotionFridView
        SWEmotionGridView *gridView = nil;
        if (i >= currentGridViewCount) {//说明SWEmotionFridView的个数不够
            gridView = [[SWEmotionGridView alloc] init];
            [self.scrollView addSubview:gridView];
            
        } else {//说明SWEmotionFridView的个数足够,从self.subViews中取出SWEmotionFridView
            gridView = self.scrollView.subviews[i];
        }
        
        //给SWEmotionFridView设置表情数据
        int loc = i * SWEmotionMaxCountPerPage;
        int len = SWEmotionMaxCountPerPage;
        if (loc + len > emotions.count) {// 对越界进行判断处理
            len = (int)(emotions.count - loc);
        }
        NSRange gridViewEmotionsRange = NSMakeRange(loc, len);
        NSArray *gridViewEmotions = [emotions subarrayWithRange:gridViewEmotionsRange];
        gridView.emotions = gridViewEmotions;
        gridView.hidden = NO;

    }
    
    //隐藏后面不需要的gridView
    for (int i = totalPages; i < currentGridViewCount; i++) {
        
        SWEmotionGridView *gridView = self.scrollView.subviews[i];
        gridView.hidden = YES;
    }
    //重新布局子控件
    [self setNeedsLayout];
    
    //表情滚动到最前面
    self.scrollView.contentOffset = CGPointZero;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.UIPageControl的frame
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.y = self.height - self.pageControl.height;
    
    // 2.UIScrollView的frame
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;

    // 3.UIScrollView的内部控件的frame
    int count = (int)self.pageControl.numberOfPages;
    CGFloat gridW = self.scrollView.width;
    CGFloat gridH = self.scrollView.height;
    self.scrollView.contentSize = CGSizeMake(count * gridW, 0);
    for (int i = 0; i < count; i++) {
        SWEmotionGridView *gridView = self.scrollView.subviews[i];
        gridView.width = gridW;
        gridView.height = gridH;
        gridView.x = i * gridView.width;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.width + 0.5);
}

@end
