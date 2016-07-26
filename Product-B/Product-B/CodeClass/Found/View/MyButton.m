//
//  MyButton.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/10.0, 0, self.frame.size.width *4/5.0, self.frame.size.height * 2/3)];
        [self addSubview:self.imageV];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height * 5 / 6.0, frame.size.width, frame.size.height / 6.0)];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
        
    }
    return self;
}






@end
