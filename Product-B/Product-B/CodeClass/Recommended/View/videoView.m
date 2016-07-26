//
//  videoView.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "videoView.h"

@implementation videoView

- (instancetype)initWithFrame:(CGRect)frame height:(CGFloat )height{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 20, 0)];
        self.titleL.numberOfLines = 0;
        self.titleL.font = [UIFont systemFontOfSize:15];
        self.titleL.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
        [self.titleL sizeToFit];
        [self addSubview:self.titleL];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, height , frame.size.width , kScreenWidth/2.0 - 10)];
        view.tag = 100;
        view.userInteractionEnabled = YES;
        //        view.backgroundColor = [UIColor clearColor];
        self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAction:)];
        [view addGestureRecognizer:self.tap];

        [self addSubview:view];
        
        self.player = [[AVPlayer alloc] init];
        AVPlayerLayer *avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        avPlayerLayer.frame = CGRectMake(0, 0 , frame.size.width , frame.size.width/2.0);
        avPlayerLayer.videoGravity = AVLayerVideoGravityResize;
        [view.layer addSublayer:avPlayerLayer];
        
        
        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,  frame.size.width / 2.0 - 30, frame.size.width, 30)];
        self.bottomView.backgroundColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:0.2];
        [view addSubview:self.bottomView];
        
        
        self.playAndPase = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.playAndPase.frame = CGRectMake(2, 2, 26, 26);
        [self.playAndPase setImage:[UIImage imageNamed:@"暂停"] forState:(UIControlStateNormal)];
        [self.playAndPase setTintColor:[UIColor whiteColor]];
        [self.playAndPase addTarget:self action:@selector(playAndPaseAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.bottomView addSubview:self.playAndPase];
        
        self.currentTime = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 40, 20)];
        self.currentTime.text = @"01:22";
        self.currentTime.font = [UIFont systemFontOfSize:12.0];
        self.currentTime.textColor = [UIColor whiteColor];
        [self.bottomView addSubview:self.currentTime];
        
        self.progress = [[UISlider alloc] initWithFrame:CGRectMake(70, 6, kScreenWidth - 80 - 70, 20)];
        [self.progress setThumbImage:[UIImage imageNamed:@"movieTicketsPayType_select"] forState:(UIControlStateNormal)];
        self.progress.minimumTrackTintColor = [UIColor whiteColor];
        [self.progress addTarget:self action:@selector(changeProgress) forControlEvents:(UIControlEventTouchUpInside)];
        [self.bottomView addSubview:self.progress];
        
        self.allTime = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 75, 5, 40, 20)];
        self.allTime.textColor = [UIColor whiteColor];
        self.allTime.text = @"12:22";
        self.allTime.font = [UIFont systemFontOfSize:12.0];
        [self.bottomView addSubview:self.allTime];
        
        self.fullScreen = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.fullScreen.frame = CGRectMake(kScreenWidth - 40, 8, 13, 13);
        [self.fullScreen setImage:[UIImage imageNamed:@"全屏播放"] forState:(UIControlStateNormal)];
        [self.fullScreen setTintColor:[UIColor whiteColor]];
        [self.fullScreen addTarget:self action:@selector(fullScreenAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.bottomView addSubview:self.fullScreen];
        
        self.start = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 , frame.size.width , frame.size.width / 2.0)];
        self.start.userInteractionEnabled = YES;
        
        UIImageView *StartBar = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2.0 - 40, kScreenWidth/4.0 - 30, 50, 50)];
        StartBar.userInteractionEnabled = YES;
        StartBar.image = [UIImage imageNamed:@"开始2"];
        [self.start addSubview:StartBar];
        [view addSubview:self.start];
            }
    return self;
}


- (void)playAndPaseAction:(UIButton *)btn{
    if (!self.isPlay) {
        [self.player play];
        [self.playAndPase setImage:[UIImage imageNamed:@"暂停"] forState:(UIControlStateNormal)];
    } else{
        [self.player pause];
        [self.playAndPase setImage:[UIImage imageNamed:@"开始"] forState:(UIControlStateNormal)];
    }
    self.isPlay = !self.isPlay;
}

- (void)showAction:(UITapGestureRecognizer *)tap{
    
    if (!self.isRemove) {
        [self.start removeFromSuperview];
        [self.player play];
        self.isPlay = YES;
        self.isRemove = YES;
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
        [timer fire];
    }
    else {
            if (self.isHiddenxxx) {
                [self showBottomView];
            } else{
                [self hiddenBottomView];
            }
            self.isHiddenxxx = !self.isHiddenxxx;
    }
}

- (void)showBottomView{
    [self.player play];
    self.bottomView.hidden = NO;
}

- (void)hiddenBottomView{
    [self.player play];
    self.bottomView.hidden = YES;
}


- (void)changeProgress{
    [self.player seekToTime:CMTimeMakeWithSeconds(self.progress.value, 1) completionHandler:^(BOOL finished) {
        [self.player play];
    }];
}



- (void)timeAction{
    if (self.player.currentTime.timescale == 0 || self.player.currentItem.duration.timescale == 0) {
        return;
    }
    long long int currentTime = self.player.currentTime.value / self.player.currentTime.timescale;
    long long int allTime = self.player.currentItem.duration.value / self.player.currentItem.duration.timescale;
    
    self.currentTime.text = [NSString stringWithFormat:@"%02lld:%02lld",currentTime / 60, currentTime % 60];
    self.allTime.text = [NSString stringWithFormat:@"%02lld:%02lld",allTime / 60,allTime % 60];
    
    self.progress.maximumValue = allTime;
//    self.progress.value = currentTime;
    }







- (void)fullScreenAction:(UIButton *)btn{
    UIView *view = [self viewWithTag:100];
    view.frame = [UIScreen mainScreen].bounds;
    
    
//    if (self.isFullscreenMode) {
//        return;
//    }
    self.originFrame = view.frame;
    CGFloat height = [[UIScreen mainScreen] bounds].size.width;
    CGFloat width = [[UIScreen mainScreen] bounds].size.height;
    CGRect frame = CGRectMake((height - width) / 2, (width - height) / 2, width, height);
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    if (!keyWindow) {
        keyWindow = [[[UIApplication sharedApplication] windows] firstObject];
    }
    self.originView = view.superview.superview;
    [keyWindow addSubview:self];
    [UIView animateWithDuration:0.3f animations:^{
        view.frame = frame;
        [view setTransform:CGAffineTransformMakeRotation(M_PI_2)];
    } completion:^(BOOL finished) {
//        self.isFullscreenMode = YES;
//        self.videoControl.fullScreenButton.hidden = YES;
//        self.videoControl.shrinkScreenButton.hidden = NO;
    }];
}



@end
