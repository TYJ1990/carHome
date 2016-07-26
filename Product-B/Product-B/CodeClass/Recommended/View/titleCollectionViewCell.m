//
//  titleCollectionViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "titleCollectionViewCell.h"

@implementation titleCollectionViewCell





- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.nameL = [[UILabel alloc] init];
        self.nameL.textAlignment = NSTextAlignmentCenter;
        self.nameL.textColor = [UIColor grayColor];
//        self.nameL.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:self.nameL];
    }
    return self;
}

- (void)cellFrameWithStrng:(NSString *)string{
    CGFloat width = [UILabel getWidthWithTitle:string font:[UIFont systemFontOfSize:17]];
    self.nameL.frame = CGRectMake(0, 5, width, 30);
    self.nameL.text = string;
    
}


@end
