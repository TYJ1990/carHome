//
//  BrandMainSecondSixButton.m
//  Product-B
//
//  Created by super on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define w self.frame.size.width
#define h self.frame.size.height
#import "BrandMainSecondSixButton.h"

@implementation BrandMainSecondSixButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)buttonTitle:(NSString *)title image:(NSString *)image name:(NSString *)name score:(NSString *)score price:(NSString *)price{
    
//    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, h*2/14)];
//    titleL.text = title;
//    [self addSubview:titleL];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, w, h*6/12)];
    [imageV sd_setImageWithURL:[NSURL URLWithString:image]];
    [self addSubview:imageV];
    
    UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(0, imageV.bottom, w, h*2/12)];
    nameL.textAlignment = NSTextAlignmentCenter;
    nameL.text = name;
    nameL.font = [UIFont systemFontOfSize:15];
    [self addSubview:nameL];
    
    UILabel *scoreL = [[UILabel alloc]initWithFrame:CGRectMake(0, nameL.bottom, w, h * 2 / 12)];
    scoreL.text = score;
    scoreL.textAlignment = NSTextAlignmentCenter;
    scoreL.font = [UIFont systemFontOfSize:12];
    scoreL.textColor = [UIColor colorWithRed:134.0/255.0 green:134.0/255.0 blue:134.0/255.0 alpha:1];
    [self addSubview:scoreL];
    
    UILabel *priceL = [[UILabel alloc]initWithFrame:CGRectMake(0, scoreL.bottom, w, h*2/12)];
    priceL.text = price;
    priceL.font = [UIFont systemFontOfSize:12];
    priceL.textColor = [UIColor redColor];
    priceL.textAlignment = NSTextAlignmentCenter;
    [self addSubview:priceL];
}
@end
