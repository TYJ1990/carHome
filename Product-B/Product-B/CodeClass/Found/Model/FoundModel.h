//
//  FoundModel.h
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmallModel.h"

@interface FoundModel : NSObject

@property(nonatomic,strong)NSMutableArray *functionlistArray;
@property(nonatomic,strong)NSMutableArray *activitylistArray;
@property(nonatomic,strong)NSMutableArray *imageadsArray;

@property(nonatomic,strong)NSString *imgurl;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *moreactivitysurl;
@property(nonatomic,strong)NSString *title;

+ (NSMutableArray *)modelCarousConfigureJsonDic:(NSDictionary *)jsonDic;
+ (FoundModel *)modelTopViewConfigureJsonDic:(NSDictionary *)jsonDic;
+ (NSMutableArray *)modelTableViewConfigureJsonDic:(NSDictionary *)jsonDic;


@end
