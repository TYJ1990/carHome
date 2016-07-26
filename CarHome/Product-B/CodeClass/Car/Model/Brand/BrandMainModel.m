//
//  BrandMainModel.m
//  Product-B
//
//  Created by super on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "BrandMainModel.h"

@implementation BrandMainModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.myid = value;
    }
}
+ (NSMutableArray *)modelJson:(NSDictionary *)jsonDic{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *maindic = jsonDic[@"result"];
    NSArray *arr = maindic[@"list"];
    for (NSDictionary *dic in arr) {
        BrandMainModel *model = [[BrandMainModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}
@end
