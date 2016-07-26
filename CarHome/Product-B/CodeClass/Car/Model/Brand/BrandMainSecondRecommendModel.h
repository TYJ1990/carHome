//
//  BrandMainSecondRecommendModel.h
//  Product-B
//
//  Created by super on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandMainSecondRecommendModel : NSObject
@property (nonatomic, strong)NSString *seriesname;
@property (nonatomic, strong)NSString *pricerange;
@property (nonatomic, strong)NSString *seriesid;
@property (nonatomic, strong)NSString *carimg;
@property (nonatomic, strong)NSString *kbscore;
+ (NSMutableArray *)modelJson:(NSDictionary *)jsonDic;

@end
