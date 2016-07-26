//
//  BrandCarModel.m
//  Product-B
//
//  Created by super on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "BrandCarModel.h"

@implementation BrandCarModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
+(NSMutableArray *)modelJson:(NSDictionary *)jsonDic{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *result = jsonDic[@"result"];
    NSArray *arr = result[@"brandlist"];
    for (NSDictionary *dic in arr) {
        BrandCarModel *model = [[BrandCarModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
        [model.sectionArray addObject:model.letter];
    }
    
    
    return array;
}
@end
