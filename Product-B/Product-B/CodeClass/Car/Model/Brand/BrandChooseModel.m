//
//  BrandChooseModel.m
//  Product-B
//
//  Created by super on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "BrandChooseModel.h"

@implementation BrandChooseModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
+ (NSMutableArray *)modelJson:(NSDictionary *)jsonDic{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *result = jsonDic[@"result"];
    NSArray *arr = result[@"metalist"];
    for (NSDictionary *dic in arr) {
        BrandChooseModel *model = [[BrandChooseModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}

@end
