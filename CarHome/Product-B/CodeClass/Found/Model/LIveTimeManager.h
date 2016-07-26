//
//  LIveTimeManager.h
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface LIveTimeManager : NSObject

@property(nonatomic,strong)NSArray *livetimeArray;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)BOOL isPlay;

@property(nonatomic,strong)AVPlayer *player;


+ (LIveTimeManager *)shareInstance;



@end
