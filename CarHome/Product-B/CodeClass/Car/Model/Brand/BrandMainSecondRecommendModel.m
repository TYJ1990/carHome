//
//  BrandMainSecondRecommendModel.m
//  Product-B
//
//  Created by super on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "BrandMainSecondRecommendModel.h"

@implementation BrandMainSecondRecommendModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
+ (NSMutableArray *)modelJson:(NSDictionary *)jsonDic{
    NSMutableArray *array = [NSMutableArray array];
    
    NSDictionary *result = jsonDic[@"result"];
    NSArray *arr = result[@"list"];
    for (NSDictionary *dic in arr) {
        BrandMainSecondRecommendModel *model = [[BrandMainSecondRecommendModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    
    return array;
}
@end
