//
//  videoView.h
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface videoView : UIView


@property(nonatomic,strong)UILabel *titleL;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIButton *playAndPase;
@property(nonatomic,strong)UILabel *currentTime;
@property(nonatomic,strong)UILabel *allTime;
@property(nonatomic,strong)UISlider *progress;
@property(nonatomic,strong)UIButton *fullScreen;
@property(nonatomic,strong)UIImageView *start;


@property(nonatomic,strong)AVPlayer *player;
@property(nonatomic,assign)BOOL isPlay;
@property(nonatomic,assign)BOOL isHiddenxxx;
@property(nonatomic,assign)BOOL isRemove;

@property(nonatomic,assign)CGRect originFrame;
@property(nonatomic,strong)UIView *originView;

@property(nonatomic,strong)UITapGestureRecognizer *tap;

- (instancetype)initWithFrame:(CGRect)frame height:(CGFloat )height;




@end
