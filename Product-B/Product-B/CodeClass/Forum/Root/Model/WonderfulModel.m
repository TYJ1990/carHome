//
//  WonderfulModel.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "WonderfulModel.h"

@implementation WonderfulModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (NSMutableArray *)modelconfigureJsonDic:(NSDictionary *)dic {
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *resultDic = dic[@"result"];
    NSArray *metaArr = resultDic[@"metalist"];
    
    NSDictionary *jxArr = metaArr[4];
    NSArray *listArr = jxArr[@"list"];
    for (NSDictionary *dic1 in listArr) {
        WonderfulModel *model = [[WonderfulModel alloc] init];
        [model setValuesForKeysWithDictionary:dic1];
        [array addObject:model];
    }
    return array;
}

@end
