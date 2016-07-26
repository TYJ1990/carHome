
//
//  LiveModel.m
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "LiveModel.h"

@implementation LiveModel


+ (NSMutableArray *)modelConfigureJsonDic:(NSDictionary *)jsonDic{
    NSMutableArray *modelArray = [NSMutableArray array];
    NSArray *array = jsonDic[@"result"][@"list"];
    for (NSDictionary *dic  in array) {
        LiveModel *model = [[LiveModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [modelArray addObject:model];
    }
    return modelArray;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}




@end
