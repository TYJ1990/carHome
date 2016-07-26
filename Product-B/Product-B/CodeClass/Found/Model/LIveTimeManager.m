//
//  LIveTimeManager.m
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "LIveTimeManager.h"


static LIveTimeManager *liveManager = nil;
@implementation LIveTimeManager

+ (LIveTimeManager *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        liveManager = [[LIveTimeManager alloc] init];
    });
    return liveManager;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        _livetimeArray = [NSArray array];
        _player = [[AVPlayer alloc] init];
        _player.volume = 40;
    }
    return self;
}






@end
