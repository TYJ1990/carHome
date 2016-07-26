//
//  MyScrollView.m
//  PhotoAlbum
//
//  Created by 胡建波 on 15/12/7.
//  Copyright © 2015年 Hu. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

//自定义一个滚动视图，上面带一张图片
- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, kScreenHeight*4/7.0 - kScreenWidth/2.0, kScreenWidth, kScreenWidth/2.0)];
        self.imageV.image = image;
        [self addSubview:self.imageV];
        
        //设置最大和最小缩放倍数
        self.maximumZoomScale = 3;
        self.minimumZoomScale = 0.5;
        self.delegate = self;
    }
    return self;
}

//指定哪个视图可以被缩放
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageV;
}



@end
