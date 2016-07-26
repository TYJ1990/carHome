//
//  FilterModel.m
//  Product-B
//
//  Created by super on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "FilterModel.h"

@implementation FilterModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
+ (NSMutableArray *)modelJson:(NSDictionary *)jsonDic{
    NSMutableArray *array = [NSMutableArray array];
    
    NSDictionary *resultDic = jsonDic[@"result"];
    NSArray *arr = resultDic[@"series"];
    for (NSDictionary *dic in arr) {
        FilterModel *model = [[FilterModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    
    return array;
}
@end
