//
//  MusicDetailViewController.h
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"

#define kDetail @"http://news.app.autohome.com.cn/radio_v5.6.0/News/newsonewradiolist-pm1-aid%@-p1-s50-tp0.json"

@interface MusicDetailViewController : UIViewController

@property(nonatomic,strong)MusicModel *model;


@end
