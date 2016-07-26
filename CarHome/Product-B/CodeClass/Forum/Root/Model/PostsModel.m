//
//  PostsModel.m
//  Product-B
//
//  Created by lanou on 16/7/14.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "PostsModel.h"

@implementation PostsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (NSMutableArray *)modelConfigureJsonDic:(NSDictionary *)dic {
    NSMutableArray *array = [NSMutableArray array];
    NSArray *listArr = dic[@"result"][@"list"];
    for (NSDictionary *dic1 in listArr) {
        PostsModel *model = [[PostsModel alloc] init];
        [model setValuesForKeysWithDictionary:dic1];
        [array addObject:model];
    }
    return array;
}

@end
