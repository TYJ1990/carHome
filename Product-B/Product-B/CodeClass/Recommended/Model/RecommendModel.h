//
//  RecommendModel.h
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendModel : NSObject

@property(nonatomic,strong)NSNumber *id;
@property(nonatomic,strong)NSNumber *mediatype;
@property(nonatomic,strong)NSNumber *replycount;
@property(nonatomic,strong)NSString *smallpic;
@property(nonatomic,strong)NSString *smallimg;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *imgurl;
@property(nonatomic,strong)NSString *indexdetail;
@property(nonatomic,assign)BOOL skisfirst;
@property(nonatomic,strong)NSNumber *playcount;
@property(nonatomic,strong)NSString *mediaid;

@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSNumber *userid;
@property(nonatomic,strong)NSString *userpic;
@property(nonatomic,strong)NSString *publishtime;
@property(nonatomic,strong)NSNumber *praisenum;
@property(nonatomic,strong)NSNumber *newsid;
@property(nonatomic,strong)NSString *videoid;
@property(nonatomic,strong)NSString *thumbnailpics;

@property(nonatomic,strong)NSString *lastid;
@property(nonatomic,strong)NSString *videoaddress;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSNumber *reviewcount;
@property(nonatomic,strong)NSString *createtime;

+ (NSMutableArray *)ModelConfigureJsonDic:(NSDictionary *)jsonDic;

+ (NSMutableArray *)ModelCarouselWithJsonDic:(NSDictionary *)jsonDic;

@end
