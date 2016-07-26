//
//  SortCollectionViewCell.m
//  Product-B
//
//  Created by lanou on 16/7/19.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "SortCollectionViewCell.h"

@implementation SortCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (kScreenWidth - 25)/4.0, 30)];
        self.label.backgroundColor = [UIColor whiteColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor grayColor];
        self.label.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:self.label];
    }
    return self;
}



@end
