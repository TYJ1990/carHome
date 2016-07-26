//
//  FilterModel.h
//  Product-B
//
//  Created by super on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterModel : NSObject
@property (nonatomic, strong)NSString *seriesname;
@property (nonatomic, strong)NSString *thumburl;
@property (nonatomic, strong)NSString *pricerange;
@property (nonatomic, strong)NSString *seriesid;
@property (nonatomic, strong)NSString *cornericon;
+ (NSMutableArray *)modelJson:(NSDictionary *)jsonDic;
@end
