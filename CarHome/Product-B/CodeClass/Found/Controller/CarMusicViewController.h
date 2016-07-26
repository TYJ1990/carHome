//
//  CarMusicViewController.h
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAlbum @"http://news.app.autohome.com.cn/radio_v5.6.0/News/newsmyradiolist-pm1-tp1.json"
#define kLive @"http://news.app.autohome.com.cn/radio_v5.6.0/news/radio-pm1-day0.json"

@interface CarMusicViewController : UIViewController

@property(nonatomic,strong)NSNumber *participantsnum;
@property(nonatomic,strong)NSString *radioinfourl;
@property(nonatomic,strong)NSString *timestamp;


@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *topic;
@property(nonatomic,strong)UILabel *anchor;
@property(nonatomic,strong)UILabel *guest;

@end
