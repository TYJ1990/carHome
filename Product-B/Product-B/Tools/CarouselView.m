//
//  CarouselView.m
//  Leisure
//
//  Created by I三生有幸I on 16/5/27.
//  Copyright © 2016年 盛辰. All rights reserved.
//
#import "CarouselView.h"
#import <UIImageView+WebCache.h>

@interface CarouselView ()<UIScrollViewDelegate>
// 最下面的scrollView
@property (nonatomic, strong) UIScrollView *scrollView;
// 网址数组
@property (nonatomic, strong) NSArray *imageURLs;
@property (nonatomic, strong) UIPageControl *pageController;
// 定时器 当用户拖拽时 不需要自动滑动 所以设置为属性
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation CarouselView
// 传入frame和装有网址的数组
- (instancetype)initWithFrame:(CGRect)frame imageURLs:(NSArray *)imageURLs {
    self = [super initWithFrame:frame];
    if (self) {
        if (imageURLs.count == 0) {
            return nil;
        }
        self.imageURLs = imageURLs;
        [self createScrollView];
        [self initImages];
        [self createPageController];
        // 两张图以上才创建timer
        if (self.imageURLs.count >= 2) {
            [self createTimer];
        }
    }
    return self;
}

- (void)createPageController {
    self.pageController = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, self.frame.size.height - 20, 50, 20)];
    [self addSubview:self.pageController];
    // 一共几个diandian
    self.pageController.numberOfPages = self.imageURLs.count;
}


- (void)createScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * self.imageURLs.count, 0);
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.scrollView];
    
}
    
- (void)initImages{
    // 如果只有一个网址（一张图片）不用循环轮播 直接创建一张imageView
    if (self.imageURLs.count == 1) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLs[0]]];
        [self.scrollView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickFunction)];
        // 给每一张图片都添加一个点击事件
        [imageView addGestureRecognizer:tap];
        // 打开imageView交互
        imageView.userInteractionEnabled = YES;
        
        return;
    }
    
    // 在左右两边各添加一张imageView
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * (self.imageURLs.count + 2), 0);
    // 整夜滚动
    self.scrollView.pagingEnabled = YES;
    // 一上来就显示第一个
    self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    for (int i = 0; i < self.imageURLs.count + 2; i++) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickFunction)];
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        
        // 给每一张图片都添加一个点击事件
        [imageView addGestureRecognizer:tap];
        
        // 打开imageView交互
        imageView.userInteractionEnabled = YES;
        
        imageView.image = [UIImage imageNamed:@"shipinbg"];
        // 第一张显示最后一张的内容
        if (i == 0) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLs.lastObject]];
        // 最后一张显示第一张的内容
        } else if (i == self.imageURLs.count + 1) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLs.firstObject]];
        } else {
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLs[i - 1]]];
        }
        [self.scrollView addSubview:imageView];
    }
}
// 图片点击
- (void)imageClickFunction {
    // 回调block
    if (self.imageClick) {
        self.imageClick(self.pageController.currentPage);
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 如果便宜到第0个 回到最后一个
    if (self.scrollView.contentOffset.x <= 0) {
        self.scrollView.contentOffset = CGPointMake(self.imageURLs.count * self.frame.size.width, 0);
    }
    if (self.scrollView.contentOffset.x >= (self.imageURLs.count + 1) * self.frame.size.width) {
        self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    }
    self.pageController.currentPage = self.scrollView.contentOffset.x / self.frame.size.width - 1;
}
/**
 *  定时器方法
 */
- (void)createTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeHander) userInfo:nil repeats:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 定时器没有提供暂停的方法  我们可以设置他在什么时间开启
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    [self createTimer];
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:kInterval]];
}


//// 当我们代码改变了偏移量 并且使用了动画的时候  会调用这个方法 不会调用结束减速的方法，我可以手动调用
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
//    [self scrollViewDidEndDecelerating:self.scrollView];
//}


// 定时器方法
- (void)timeHander {
    CGPoint offSet = self.scrollView.contentOffset;
    offSet.x += self.frame.size.width;
    [self.scrollView setContentOffset:offSet animated:YES];
}






@end
