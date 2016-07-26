//
//  NewsflashModel.m
//  Product-B
//
//  Created by lanou on 16/7/18.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "NewsflashModel.h"

@implementation NewsflashModel


+ (NSMutableArray *)ModelConfigureJsonDic:(NSDictionary *)jsonDic{
    NSMutableArray *modelArray = [NSMutableArray array];
    NSArray *arr = jsonDic[@"result"][@"messagelist"];
    for (NSDictionary *dic in arr) {
        NewsflashModel *model = [[NewsflashModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        NSArray *array = dic[@"commentlist"];
        
        for (int i = 0; i < array.count; i++) {
            if (i == 0) {
                model.headimg1 = array[i][@"headimg"];
                model.username1 = array[i][@"username"];
                model.content1 = array[i][@"content"];
            }
            if(i == 1 ){
                model.headimg2 = array[i][@"headimg"];
                model.username2 = array[i][@"username"];
                model.content2 = array[i][@"content"];
            }
            if (i == 2) {
                model.headimg3 = array[i][@"headimg"];
                model.username3 = array[i][@"username"];
                model.content3 = array[i][@"content"];
            }
        }
        [modelArray addObject:model];
    }
    return modelArray;
}




- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}








@end
