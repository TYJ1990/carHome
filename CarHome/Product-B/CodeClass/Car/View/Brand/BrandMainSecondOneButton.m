//
//  BrandMainSecondOneButton.m
//  Product-B
//
//  Created by super on 16/7/20.
//  Copyright © 2016年 wxl. All rights reserved.
//
#define h self.frame.size.height
#define w self.frame.size.width
#import "BrandMainSecondOneButton.h"

@implementation BrandMainSecondOneButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)title:(NSString *)title content:(NSString *)content{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
    [self addSubview:view];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(10, h/6, self.frame.size.width, h/3)];
    self.label.text = title;
    [view addSubview:self.label];
    
    self.clabel = [[UILabel alloc]initWithFrame:CGRectMake(10, h/6*4, self.frame.size.width, h/6)];
    self.clabel.text = content;
    self.clabel.font = [UIFont systemFontOfSize:10];
    [view addSubview:self.clabel];
    
}
@end
