

//
//  RecommendModel.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "RecommendModel.h"

@implementation RecommendModel


+ (NSMutableArray *)ModelConfigureJsonDic:(NSDictionary *)jsonDic{
    NSMutableArray *modelArray = [NSMutableArray array];
    NSArray *arr = jsonDic[@"result"][@"newslist"];
    if (arr) {
        for (NSDictionary *dict in arr) {
            RecommendModel *model = [[RecommendModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            model.thumbnailpics = [dict[@"thumbnailpics"] firstObject];
            [modelArray addObject:model];
        }
    } else{
        NSArray *arr = jsonDic[@"result"][@"list"];
        for (NSDictionary *dict in arr) {
            RecommendModel *model = [[RecommendModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [modelArray addObject:model];
        }
    }
    return modelArray;
}

+ (NSMutableArray *)ModelCarouselWithJsonDic:(NSDictionary *)jsonDic{
    NSMutableArray *modelArray = [NSMutableArray array];

    NSArray *arr = jsonDic[@"result"][@"focusimg"];
    if (arr.count > 0) {
        NSArray *arr = jsonDic[@"result"][@"focusimg"];
        for (NSDictionary *dict in arr) {
//            NSString *urlString = dict[@"imgurl"];
//            [modelArray addObject:urlString];
            RecommendModel *model = [[RecommendModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [modelArray addObject:model];
        }
    } else{
        NSArray *arr2 = jsonDic[@"result"][@"focusimgs"];
        for (NSDictionary *dict in arr2) {
            RecommendModel *model = [[RecommendModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [modelArray addObject:model];
        }
    }
    return modelArray;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}














@end
