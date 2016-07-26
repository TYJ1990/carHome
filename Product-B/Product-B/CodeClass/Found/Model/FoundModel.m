//
//  FoundModel.m
//  Product-B
//
//  Created by lanou on 16/7/20.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "FoundModel.h"

@implementation FoundModel


- (instancetype)init{
    self = [super init];
    if (self) {
        self.activitylistArray = [NSMutableArray array];
        self.functionlistArray = [NSMutableArray array];
        self.imageadsArray = [NSMutableArray array];
    }
    return self;
}


+ (NSMutableArray *)modelCarousConfigureJsonDic:(NSDictionary *)jsonDic{
    NSMutableArray *modelArray = [NSMutableArray array];
    NSArray *array = jsonDic[@"result"][@"list"];
    for (NSDictionary *dic in array) {
        FoundModel *model = [[FoundModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [modelArray addObject:model];
    }
    return modelArray;
}


+ (NSMutableArray *)modelTableViewConfigureJsonDic:(NSDictionary *)jsonDic{
    NSMutableArray *modelArray = [NSMutableArray array];

    NSMutableArray *like = [NSMutableArray array];
    NSArray *arr1 = jsonDic[@"result"][@"modulelist"];
    NSArray *listArray = arr1[0][@"list"];
    for (NSDictionary *dic  in listArray) {
        SmallModel *model = [[SmallModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [like addObject:model];
    }
    NSString *title = arr1[0][@"title"];
    [like addObject:title];
    [modelArray addObject:like];
    
    NSMutableArray *introduce = [NSMutableArray array];
    NSArray *listArray2 = arr1[1][@"list"];
    for (NSDictionary *dic  in listArray2) {
        SmallModel *model = [[SmallModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [introduce addObject:model];
    }
    NSString *title2 = arr1[1][@"title"];
    [introduce addObject:title2];
    [modelArray addObject:introduce];
    
    NSMutableArray *goodslist = [NSMutableArray array];
    NSArray *arr2 = jsonDic[@"result"][@"goodslist"][@"list"];
    for (NSDictionary *dic  in arr2) {
        SmallModel *model = [[SmallModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [goodslist addObject:model];
    }
//    NSString *carmallurl = jsonDic[@"result"][@"goodslist"][@"carmallurl"];
//    [goodslist addObject:carmallurl];
    [modelArray addObject:goodslist];
    
    return modelArray;
}

+(FoundModel *)modelTopViewConfigureJsonDic:(NSDictionary *)jsonDic{
    FoundModel *model = [[FoundModel alloc] init];
    
    NSArray *activitylist = jsonDic[@"result"][@"activitylist"];
    for (NSDictionary *dic  in activitylist) {
        SmallModel *smallModel = [[SmallModel alloc] init];
        [smallModel setValuesForKeysWithDictionary:dic];
        [model.activitylistArray addObject:smallModel];
    }
    
    NSArray *functionlist = jsonDic[@"result"][@"functionlist"];
    for (NSDictionary *dic  in functionlist) {
        SmallModel *smallModel = [[SmallModel alloc] init];
        [smallModel setValuesForKeysWithDictionary:dic];
        [model.functionlistArray addObject:smallModel];
    }
    
    NSArray *imageads = jsonDic[@"result"][@"imageads"][@"imageadsinfo"];
    for (NSDictionary *dic  in imageads) {
        SmallModel *smallModel = [[SmallModel alloc] init];
        [smallModel setValuesForKeysWithDictionary:dic];
        [model.imageadsArray addObject:smallModel];
    }
    model.moreactivitysurl = jsonDic[@"result"][@"imageads"][@"moreactivitysurl"];
    model.title = jsonDic[@"result"][@"imageads"][@"title"];
    
    return model;
}








- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}












@end
