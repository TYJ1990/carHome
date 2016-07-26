//
//  FilterChooseModel.h
//  Product-B
//
//  Created by super on 16/7/25.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterChooseModel : NSObject
@property (nonatomic, strong)NSArray *seriesitems;
@property (nonatomic, strong)NSString *pageindex;
@property (nonatomic, strong)NSString *rowcount;
@property (nonatomic, strong)NSString *totalspeccount;

@property (nonatomic, strong)NSString *myid;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *img;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, strong)NSString *count;
+ (NSMutableArray *)modelJson:(NSDictionary *)jsonDic;
@end
