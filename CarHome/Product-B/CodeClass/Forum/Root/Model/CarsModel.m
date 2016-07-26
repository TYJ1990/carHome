//
//  CarsModel.m
//  Product-B
//
//  Created by lanou on 16/7/17.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "CarsModel.h"

@interface CarsModel()
//@property (nonatomic, strong) NSString *itme;
@end
static NSString *itme;
static NSMutableArray *array;
@implementation CarsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


+ (NSMutableDictionary *)modelConfigureJsonDic:(NSDictionary *)dic {
    NSMutableDictionary *allDic = [NSMutableDictionary dictionary];
    
    NSArray *listArr = dic[@"result"][@"list"];
    for (NSDictionary *dic1 in listArr) {
        CarsModel *model = [[CarsModel alloc] init];
        [model setValuesForKeysWithDictionary:dic1];
        
        if ([itme isEqualToString:model.letter]) {
            [array addObject:model];
            [allDic setValue:array forKey:itme];
        } else {
            itme = model.letter;
            array = [NSMutableArray array];
            [array addObject:model];
            [allDic setValue:array forKey:itme];
        }

    }

    return allDic;
}


@end
