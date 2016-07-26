//
//  LabelAndImageView.m
//  Product-B
//
//  Created by lanou on 16/7/15.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "LabelAndImageView.h"

@implementation LabelAndImageView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.thumbpics = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
        [self addSubview:self.thumbpics];
        self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, kScreenWidth - 80 - 20, 60)];
        self.titleL.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        self.titleL.font = [UIFont systemFontOfSize:15];
        self.titleL.numberOfLines = 2;
        [self addSubview:self.titleL];
        self.barImage = [[UIImageView alloc] initWithFrame:CGRectMake(85, 5, 15, 15)];
        self.barImage.image = [UIImage imageNamed:@"别针"];
        self.titleL.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
        [self addSubview:self.barImage];
    }
    return self;
}





@end
