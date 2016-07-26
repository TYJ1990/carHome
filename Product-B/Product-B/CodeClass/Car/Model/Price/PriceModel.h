//
//  PriceModel.h
//  Product-B
//
//  Created by super on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PriceModel : NSObject
@property (nonatomic, strong)NSString *myid;
@property (nonatomic, strong)NSString *specpic;
@property (nonatomic, strong)NSString *specname;
@property (nonatomic, strong)NSString *dealerprice;
@property (nonatomic, strong)NSString *fctprice;
@property (nonatomic, strong)NSString *city;
@property (nonatomic, strong)NSString *shortname;
@property (nonatomic, strong)NSString *distance;
@property (nonatomic, strong)NSString *orderrange;
+ (NSMutableArray *)modelJson:(NSDictionary *)jsonDic;

@end
