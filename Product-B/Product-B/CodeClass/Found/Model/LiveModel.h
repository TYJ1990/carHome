//
//  LiveModel.h
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiveModel : NSObject

@property(nonatomic,strong)NSString *album;
@property(nonatomic,strong)NSNumber *albumid;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *anchor;
@property(nonatomic,strong)NSString *starttime;
@property(nonatomic,strong)NSString *endtime;
@property(nonatomic,strong)NSString *radiopicurl;
@property(nonatomic,strong)NSString *shareurl;
@property(nonatomic,strong)NSString *programtime;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *honoredguest;

@property(nonatomic,assign)BOOL isAppoint;
@property(nonatomic,assign)BOOL isTomorrow;



+(NSMutableArray *)modelConfigureJsonDic:(NSDictionary *)jsonDic;




@end
