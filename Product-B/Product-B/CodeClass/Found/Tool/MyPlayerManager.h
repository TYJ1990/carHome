//
//  MyPlayerManager.h
//  Product- A
//
//  Created by lanou on 16/6/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "BottomView.h"

// 播放模式
typedef NS_ENUM(NSInteger, PlayType){
    SignlePlay,
    RandomPlay,
    ListPlay
};
// 播放状态
typedef NS_ENUM(NSInteger, PlayState){
    Play,
    Pause
};
typedef void(^Block)();

@interface MyPlayerManager : NSObject
@property(nonatomic,copy)Block resultBlock;

@property(nonatomic,assign)PlayState playState;
@property(nonatomic,assign)PlayType playType;
@property(nonatomic,strong)AVPlayer *avPlayer;
@property(nonatomic,strong)NSMutableArray *musicLists;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)float currentTime;
@property(nonatomic,assign)float totalTime;

@property(nonatomic,assign)BOOL isPlay;

@property(nonatomic,strong)BottomView *bottiomView;
@property(nonatomic,strong)NSMutableDictionary *dic;
@property(nonatomic,strong)NSString *albumName;

+ (MyPlayerManager *)defaultManager;

- (void)seekToSecondsWith:(float)seconds;
- (float)currentTime;
- (float)totalTime;
- (void)lastMusic;
- (void)nextMusic;
-(void)changeMusicWith:(NSInteger )index;
-(void)playerDidFinish;
- (void)play;
- (void)pause;
- (void)stop;




@end
