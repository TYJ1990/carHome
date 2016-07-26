//
//  MusicModel.m
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel


+ (NSMutableArray *)modelConfigureJsonDic:(NSDictionary *)jsonDic{
    NSMutableArray *modelArray = [NSMutableArray array];
    NSArray *array = jsonDic[@"result"][@"list"];
    for (NSDictionary *dic  in array) {
        MusicModel *model = [[MusicModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [modelArray addObject:model];
    }
    
    return modelArray;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}



@end
