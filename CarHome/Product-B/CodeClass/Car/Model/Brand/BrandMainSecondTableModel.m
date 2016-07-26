//
//  BrandMainSecondTableModel.m
//  Product-B
//
//  Created by super on 16/7/21.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "BrandMainSecondTableModel.h"

@implementation BrandMainSecondTableModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
+ (NSMutableArray *)arrayjson:(NSDictionary *)jsonDic{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *enginelist = jsonDic[@"result"][@"enginelist"];
    for (NSDictionary *dic in enginelist) {
        BrandMainSecondTableModel *model = [[BrandMainSecondTableModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    
    return array;
}
@end
