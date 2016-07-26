//
//  BrandHotModel.m
//  Product-B
//
//  Created by super on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "BrandHotModel.h"

@implementation BrandHotModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.myid = value;
    }
}
+ (NSMutableArray *)modelJson:(NSDictionary *)jsonDic{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *resultdic = jsonDic[@"result"];
    NSArray *arr = resultdic[@"list"];
    for (NSDictionary *dic in arr) {
        BrandHotModel *model = [[BrandHotModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}
@end
