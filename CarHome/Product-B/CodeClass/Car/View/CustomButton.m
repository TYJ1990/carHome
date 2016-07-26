//
//  CustomButton.m
//  Product-B
//
//  Created by super on 16/7/12.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define W self.frame.size.width
#define H self.frame.size.height
#import "CustomButton.h"
#import <SDWebImage/SDImageCache.h>
@implementation CustomButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)image:(NSString *)image title:(NSString *)title imgurl:(NSString *)imgurl{
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(W/8, 0, W/4*3, H/4*3)];
//    imageV.backgroundColor = [UIColor yellowColor];
    if (image == nil) {
        [imageV sd_setImageWithURL:[NSURL URLWithString:imgurl]];
    }else{
        imageV.image = [UIImage imageNamed:image];

    }
//    imageV.backgroundColor = [UIColor yellowColor];
    [self addSubview:imageV];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, H/4*3, W, H/4)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1];
//    label.backgroundColor = [UIColor yellowColor];

    label.text = title;
    [self addSubview:label];
}
@end
