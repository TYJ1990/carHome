//
//  BottomView.m
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "BottomView.h"
#import "MusicPlayViewController.h"
#import "LIveTimeManager.h"
#import "MyPlayerManager.h"
#import "ListViewController.h"

@implementation BottomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
        
        self.blurView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 55)];
        self.blurView.backgroundColor = [UIColor blackColor];
        self.blurView.alpha = 0.85;
        [self addSubview:self.blurView];
        
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7.5, 40, 40)];
        self.icon.layer.masksToBounds = YES;
        self.icon.layer.cornerRadius = 20;
        [self addSubview:self.icon];
        
        self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, kScreenWidth - 60 - 100, 15)];
        self.titleL.font = [UIFont systemFontOfSize:15.0];
        self.titleL.textColor = [UIColor whiteColor];
        [self addSubview:self.titleL];
        
        self.album = [[UILabel alloc] initWithFrame:CGRectMake(60, self.titleL.bottom + 5, kScreenWidth - 160, 15)];
        self.album.textColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        self.album.font = [UIFont systemFontOfSize:11.0];
        [self addSubview:self.album];
        
        self.play = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.play.frame = CGRectMake(kScreenWidth - 75, 18, 25, 20);
        [self.play setTintColor:[UIColor whiteColor]];
        [self.play addTarget:self action:@selector(bottomPlay) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.play];
        
        self.next = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.next.frame = CGRectMake(kScreenWidth - 35, 18, 20, 20);
        [self.next setTintColor:[UIColor whiteColor]];
//        [self.next addTarget:self action:@selector(prensetAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.next];
        
//        self.listView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
//        ListViewController *listVC = [[ListViewController alloc] init];
//        [self.listView addSubview:listVC.view];
//        [self addSubview:self.listView];
        
        
    }
    return self;
}



- (void)tapAction:(UITapGestureRecognizer *)tap{
    MusicPlayViewController *musicVC = [[MusicPlayViewController alloc] init];
    musicVC.picurl = self.icon.image;
    musicVC.album = self.album.text;
    [self.vc presentViewController:musicVC animated:YES completion:nil];
}

- (void)bottomPlay{
    
    if ([LIveTimeManager shareInstance].isPlay && !self.isPause) {
        [LIveTimeManager shareInstance].isPlay = NO;
        [[LIveTimeManager shareInstance].player pause];
        self.isPause = YES;
        [self.play setImage:[UIImage imageNamed:@"开始3"] forState:(UIControlStateNormal)];
    }else{
        [LIveTimeManager shareInstance].isPlay = YES;
        [[LIveTimeManager shareInstance].player play];
        self.isPause = NO;
        [self.play setImage:[UIImage imageNamed:@"暂停2"] forState:(UIControlStateNormal)];
    }
}

- (void)prensetAction{
//    [UIView animateWithDuration:0.1 animations:^{
//        self.listView.frame = CGRectMake(0, -kScreenHeight, kScreenWidth, kScreenHeight);
//    }];
    UIView *view = [self.vc.view viewWithTag:521];
    [UIView animateWithDuration:0.1 animations:^{
        view.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth);
    }];
}







@end
