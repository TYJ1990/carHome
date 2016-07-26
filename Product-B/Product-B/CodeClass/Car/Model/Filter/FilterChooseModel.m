//
//  FilterChooseModel.m
//  Product-B
//
//  Created by super on 16/7/25.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "FilterChooseModel.h"

@implementation FilterChooseModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.myid = value;
    }
}
+ (NSMutableArray *)modelJson:(NSDictionary *)jsonDic{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *result = jsonDic[@"result"];
    
    //    NSArray *arr = result[@"seriesitems"];
    //    for (NSDictionary *dic in arr) {
    FilterChooseModel *model = [[FilterChooseModel alloc]init];
    [model setValuesForKeysWithDictionary:result];
    [array addObject:model];
    //    }
    
    
    
    return array;
}

@end
