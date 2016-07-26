//
//  RTModel.m
//  Product-B
//
//  Created by lanou on 16/7/17.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "RTModel.h"
static NSString *itme;
static NSMutableArray *array;
@implementation RTModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (NSMutableArray *)modelConfigureJsonDic:(NSDictionary *)dic {
    NSMutableArray *array = [NSMutableArray array];
    NSArray *listArr = dic[@"result"][@"list"];
    for (NSDictionary *dic1 in listArr) {
        RTModel *model = [[RTModel alloc] init];
        [model setValuesForKeysWithDictionary:dic1];
        [array addObject:model];
    }
    return array;
}

+ (NSMutableDictionary *)modelConfigureDic:(NSDictionary *)dic {
    NSMutableDictionary *allDic = [NSMutableDictionary dictionary];
    NSArray *listArr = dic[@"result"][@"list"];
    for (NSDictionary *dic1 in listArr) {
        RTModel *model = [[RTModel alloc] init];
        [model setValuesForKeysWithDictionary:dic1];
        if ([itme isEqualToString:model.firstletter]) {
            [array addObject:model];
            [allDic setValue:array forKey:itme];
        } else {
            itme = model.firstletter;
            array = [NSMutableArray array];
            [array addObject:model];
            [allDic setValue:array forKey:itme];
        }
        
    }
    return allDic;
}

@end
