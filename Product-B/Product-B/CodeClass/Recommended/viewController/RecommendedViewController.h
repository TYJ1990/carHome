//
//  RecommendedViewController.h
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 wxl. All rights reserved.
//
#import <UIKit/UIKit.h>

#define zuixin @"http://news.app.autohome.com.cn/news_v6.0.0/news/shouye-pm1-c0-nt0-p1-s30-l0-sd.json"
#define youchuang @"http://news.app.autohome.com.cn/news_v6.1.0/newspf/NPNewsList.ashx?a=2&pm=1&v=6.1.0&au=&type=3&size=30"
#define kuaibao @"http://news.app.autohome.com.cn/fastnews_v5.9.5/news/fastnewslist-pm1-b0-l0-s20-lastid0.json"
#define shipin @"http://news.app.autohome.com.cn/news_v6.0.0/news/videolist-pm1-vt0-s30-lastid0.json"
#define xinwen @"http://app.api.autohome.com.cn/autov4.2.5/news/newslist-a2-pm1-v4.2.5-c0-nt1-p1-s30-l0.html"
#define pingce @"http://app.api.autohome.com.cn/autov4.2.5/news/newslist-a2-pm1-v4.2.5-c0-nt3-p1-s30-l0.html"
#define daogou @"http://app.api.autohome.com.cn/autov4.2.5/news/newslist-a2-pm1-v4.2.5-c0-nt60-p1-s30-l0.html"
#define hangqing @"http://app.api.autohome.com.cn/autov4.2.5/news/newslist-a2-pm1-v4.2.5-c0-nt2-p1-s30-l0.html"
#define yongche @"http://app.api.autohome.com.cn/autov4.2.5/news/newslist-a2-pm1-v4.2.5-c0-nt82-p1-s30-l0.html"
#define jishu @"http://app.api.autohome.com.cn/autov4.2.5/news/newslist-a2-pm1-v4.2.5-c0-nt102-p1-s30-l0.html"
#define wenhua @"http://app.api.autohome.com.cn/autov4.2.5/news/newslist-a2-pm1-v4.2.5-c0-nt97-p1-s30-l0.html"
#define gaizhuang @"http://news.app.autohome.com.cn/news_v6.0.0/news/newslist-pm1-c0-nt107-p1-s30-l0-sd.json"
#define youji @"http://app.api.autohome.com.cn/autov4.2.5/news/newslist-a2-pm1-v4.2.5-c0-nt100-p1-s30-l0.html"
#define yuanchuangshipin @"http://news.app.autohome.com.cn/news_v6.0.0/news/videolist-pm1-vt8-s30-lastid0.json"
#define shuoke @"http://news.app.autohome.com.cn/news_v6.0.0/news/shuokelist-pm1-s30-lastid0.json"

//http://223.99.255.20/news.app.autohome.com.cn/news_v6.1.0/newspf/NPNewsList.ashx?a=2&pm=1&v=6.1.0&au=&type=3&lastid=&lastuid=27655328&size=30

@interface RecommendedViewController : UIViewController

@property(nonatomic,assign)NSInteger index;


@end
