//
//  BrandCarSecondModel.m
//  Product-B
//
//  Created by super on 16/7/18.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "BrandCarSecondModel.h"

@implementation BrandCarSecondModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
+ (NSMutableArray *)modelJson:(NSDictionary *)jsonDic{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *result = jsonDic[@"result"];
    NSArray *arr = result[@"fctlist"];
    for (NSDictionary *dic in arr) {
        BrandCarSecondModel *model = [[BrandCarSecondModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    
    return array;
}
@end
