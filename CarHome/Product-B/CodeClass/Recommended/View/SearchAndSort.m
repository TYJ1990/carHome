//
//  SearchAndSort.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "SearchAndSort.h"

@implementation SearchAndSort


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.sortBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.sortBtn.frame = CGRectMake(6, 13, 22, 22);
        self.sortBtn.tintColor = self.tintColor;
        [self.sortBtn setImage:[UIImage imageNamed:@"下拉"] forState:(UIControlStateNormal)];
//        [self.sortBtn addTarget:self action:@selector(pushAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.sortBtn];
        self.searchBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.searchBtn.frame = CGRectMake(40, 13, 23, 23);
        self.searchBtn.tintColor = self.tintColor;
        [self.searchBtn setImage:[UIImage imageNamed:@"搜索"] forState:(UIControlStateNormal)];
//        [self.searchBtn addTarget:self action:@selector(pushAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.searchBtn];
    }
    return self;
}



@end
