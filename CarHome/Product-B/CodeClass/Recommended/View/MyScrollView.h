//
//  MyScrollView.h
//  PhotoAlbum
//
//  Created by 胡建波 on 15/12/7.
//  Copyright © 2015年 Hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic,strong)UIImageView *imageV;

//自定义初始化方法
- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image;


@end
