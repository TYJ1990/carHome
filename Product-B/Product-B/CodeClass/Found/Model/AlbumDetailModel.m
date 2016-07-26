//
//  AlbumDetailModel.m
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "AlbumDetailModel.h"

@implementation AlbumDetailModel


+ (NSMutableArray *)modelConfigureJsonDic:(NSDictionary *)jsonDic{
    NSMutableArray *modelArray = [NSMutableArray array];
    NSArray *array = jsonDic[@"result"][@"list"];
    for (NSDictionary *dic  in array) {
        AlbumDetailModel *model = [[AlbumDetailModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [modelArray addObject:model];
    }
    NSNumber *radiozancount = jsonDic[@"result"][@"radiozancount"];
    [modelArray addObject:radiozancount];
    return modelArray;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


- (instancetype)init{
    self = [super init];
    if (self) {
        _anchor = [NSArray array];
    }
    return self;
}


@end
