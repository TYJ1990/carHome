//
//  PriceModel.m
//  Product-B
//
//  Created by super on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "PriceModel.h"

@implementation PriceModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.myid = value;
    }
}
+ (NSMutableArray *)modelJson:(NSDictionary *)jsonDic{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *resultDic = jsonDic[@"result"];
    NSArray *arr = resultDic[@"carlist"];
    for (NSDictionary *dic in arr) {
        PriceModel *model = [[PriceModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        NSDictionary *dic2 = dic[@"dealer"];
        [model setValuesForKeysWithDictionary:dic2];
        [array addObject:model];
        
    }
    
    return array;
}
@end
