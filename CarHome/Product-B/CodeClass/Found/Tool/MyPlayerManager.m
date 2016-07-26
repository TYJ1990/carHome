//
//  MyPlayerManager.m
//  Product- A
//
//  Created by lanou on 16/6/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MyPlayerManager.h"
#import "LiveModel.h"
#import "AlbumDetailModel.h"

@implementation MyPlayerManager

+ (MyPlayerManager *)defaultManager{
    static MyPlayerManager *myPlayerManger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myPlayerManger = [[MyPlayerManager alloc] init];
    });
    return myPlayerManger;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _playType = ListPlay;
        _playState = Play;
    }
    return self;
}


// 设置数据
- (void)setMusicLists:(NSMutableArray *)musicLists{
    [_musicLists removeAllObjects];
    _musicLists = [musicLists mutableCopy];
    AlbumDetailModel *model = _musicLists[_index];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:model.program_fileurl]];
    if (!_avPlayer) {
        // 没有，初始化
        _avPlayer = [[AVPlayer alloc] initWithPlayerItem:item];
        _avPlayer.volume = 50;
    } else{
        // 有
//        [_avPlayer replaceCurrentItemWithPlayerItem:item];
    }
}

// 播放
- (void)play{
    [_avPlayer play];
    _playState = Play;
    
//    self.resultBlock();
}
- (void)pause{
    [_avPlayer pause];
    _playState = Pause;
}

- (void)stop{
    [self seekToSecondsWith:0];
    _playState = Pause;
}

// 改变当前播放源的时间
- (void)seekToSecondsWith:(float)seconds{
    CMTime newTime = _avPlayer.currentTime;
    newTime.value = newTime.timescale * seconds;
    [_avPlayer seekToTime:newTime];
}


#pragma mark --- 时间获取
- (float)currentTime{
    if (_avPlayer.currentTime.timescale == 0) {
        return 0;
    }
    return _avPlayer.currentTime.value /_avPlayer.currentTime.timescale;
}
- (float)totalTime{
    if (_avPlayer.currentItem.duration.timescale == 0) {
        return 0;
    }
    return _avPlayer.currentItem.duration.value / _avPlayer.currentItem.duration.timescale;
}
//上一首
- (void)lastMusic{
    if (_playType == RandomPlay) {
        _index = arc4random() %_musicLists.count;
    } else {
        if (_index == 0) {
            _index = _musicLists.count - 1;
        } else{
            _index --;
        }
    }
    [self changeMusicWith:_index];
}
// 下一首
- (void)nextMusic{
    if (_playType == RandomPlay) {
        _index = arc4random() %_musicLists.count;
    } else {
        if (_index == _musicLists.count - 1) {
            _index = 0;
        } else {
            _index ++;
        }
    }
    [self changeMusicWith:_index];
}

// 根据index来切歌
-(void)changeMusicWith:(NSInteger )index{
    _index = index;
    AlbumDetailModel *model = _musicLists[_index];
//    if (model.) {
//        AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:model.title]];
//        [_avPlayer replaceCurrentItemWithPlayerItem:playerItem];
////        NSLog(@"%@",model.savePath);
//    } else{
        AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:model.program_fileurl]];
        [_avPlayer replaceCurrentItemWithPlayerItem:playerItem];
//    }
    [self play];
//    model.isPlay = YES;
    
    self.dic[@"title"] = [NSString stringWithFormat:@"%@ %@",model.program_live_time,model.program_title];
    
    
}

-(void)playerDidFinish{
    if (_playType == SignlePlay) {
        AlbumDetailModel *model = _musicLists[_index];
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:model.program_fileurl]];
        [_avPlayer replaceCurrentItemWithPlayerItem:item];
    } else{
        [self nextMusic];
    }
}


- (void)setBottiomView:(BottomView *)bottiomView{
    _bottiomView = bottiomView;
    
    NSDictionary *dic = self.dic;
    [_bottiomView.icon sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]] placeholderImage:[UIImage imageNamed:@""]];
    _bottiomView.titleL.text = dic[@"title"];
    _bottiomView.album.text = dic[@"albumname"];
    [_bottiomView.next setImage:[UIImage imageNamed:@"下一首"] forState:(UIControlStateNormal)];
    if (self.isPlay) {
        [_bottiomView.play setImage:[UIImage imageNamed:@"开始3"] forState:(UIControlStateNormal)];
    }else {
        [_bottiomView.play setImage:[UIImage imageNamed:@"暂停3"] forState:(UIControlStateNormal)];
    }
}







@end
