//
//  BrandMainSecondModel.m
//  Product-B
//
//  Created by super on 16/7/20.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "BrandMainSecondModel.h"

@implementation BrandMainSecondModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
+ (BrandMainSecondModel *)modelJson:(NSDictionary *)jsonDic{
//    NSMutableArray *array = [NSMutableArray array];
//    NSArray *tabinfos = jsonDic[@"result"][str];
//    for (NSDictionary *dic in tabinfos) {
//        BrandMainSecondModel *model = [[BrandMainSecondModel alloc]init];
//        [model setValuesForKeysWithDictionary:jsonDic[@"result"]];
//        [model setValuesForKeysWithDictionary:dic];
//        [array addObject:model];
//    }
//    
//    return array;
    
    NSDictionary *dic = jsonDic[@"result"];
    BrandMainSecondModel *model = [[BrandMainSecondModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    
    return model;
    
}

@end
