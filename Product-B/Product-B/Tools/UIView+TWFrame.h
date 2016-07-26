//
//  UIView+TWFrame.h
//  TWFollow-master
//
//  Created by lanou on 16/5/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface UIView (TWFrame)

@property (nonatomic , assign) CGFloat left;

@property (nonatomic , assign, readonly) CGFloat right;

@property (nonatomic , assign) CGFloat width;

@property (nonatomic , assign) CGFloat height;

@property (nonatomic , assign) CGFloat top;

@property (nonatomic , assign ,readonly) CGFloat bottom;

@property (nonatomic , assign) CGFloat centerX;

@property (nonatomic , assign) CGFloat centerY;

@end
