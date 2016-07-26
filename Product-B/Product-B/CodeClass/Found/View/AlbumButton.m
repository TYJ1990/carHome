//
//  AlbumButton.m
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "AlbumButton.h"

@implementation AlbumButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat width = kScreenWidth/3.0;
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(width/5.0, 0, width * 3 / 5.0, width * 3 / 5.0)];
        self.imageV.layer.masksToBounds = YES;
        self.imageV.layer.cornerRadius = width * 3 / 10.0;
        [self addSubview:self.imageV];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, width * 3 / 5.0 + 10 , width, (width * 2 / 5.0 -10) * 2 / 5.0)];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:self.title];
        
        self.timeL = [[UILabel alloc] initWithFrame:CGRectMake(0, self.title.bottom + 3, width, width - self.title.bottom - 5)];
        self.timeL.font = [UIFont systemFontOfSize:10.0];
        self.timeL.textColor = [UIColor lightGrayColor];
        self.timeL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.timeL];
    
    }
    return self;
}

@end
