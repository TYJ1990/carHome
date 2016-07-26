//
//  BlurView.m
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "BlurView.h"

@implementation BlurView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, frame.size.height)];
        self.background.image = [UIImage imageNamed:@"background2.jpeg"];
        [self addSubview:self.background];
        
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, frame.size.height - 150, 50, 50)];
        self.icon.layer.masksToBounds = YES;
        self.icon.layer.cornerRadius = 25;
        [self addSubview:self.icon];
        
        self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(self.icon.right + 15, self.icon.top- 3, kScreenWidth - 80, 15)];
        self.titleL.font = [UIFont systemFontOfSize:15.0];
        self.titleL.textColor = [UIColor whiteColor];
        [self addSubview:self.titleL];
        
        self.content = [[UILabel alloc] initWithFrame:CGRectMake(self.titleL.left, self.titleL.bottom + 6, kScreenWidth - 85, 45)];
        self.content.font = [UIFont systemFontOfSize:12.0];
        self.content.textColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        self.content.numberOfLines = 3;
        [self addSubview:self.content];
        
        self.like = [[UILabel alloc ] initWithFrame:CGRectMake(kScreenWidth - 75, frame.size.height - 65, 70, 15)];
        self.like.font = [UIFont systemFontOfSize:12.0];
        self.like.textColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        [self addSubview:self.like];
        
        self.likeBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.likeBtn setTintColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]];
        self.likeBtn.frame = CGRectMake(self.like.left - 18, self.like.top, 16, 16);
        [self.likeBtn setImage:[UIImage imageNamed:@"心"] forState:(UIControlStateNormal)];
        [self addSubview:self.likeBtn];
        
        self.timeBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.timeBtn.frame = CGRectMake(10, frame.size.height - 30, 40, 20);
        [self.timeBtn setTitle:@"按时间" forState:(UIControlStateNormal)];
        self.timeBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [self.timeBtn setTintColor:self.tintColor];
        [self addSubview:self.timeBtn];
        
        self.hotBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.hotBtn.frame = CGRectMake(self.timeBtn.right + 5 , self.timeBtn.top, 40, 20);
        [self.hotBtn setTitle:@"按热门" forState:(UIControlStateNormal)];
        self.hotBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [self.hotBtn setTintColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1]];
        [self addSubview:self.hotBtn];
        
    }
    return self;
}







@end
