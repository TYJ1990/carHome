//
//  HeadView.m
//  Product-B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.title = [[UILabel alloc] init];
        [self addSubview:self.title];
    }
    return self;
}


@end
