//
//  CommentModel.m
//  Product-B
//
//  Created by lanou on 16/7/16.
//  Copyright © 2016年 wxl. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel


+ (NSMutableArray *)ModelConfigureJsonDic:(NSDictionary *)jsonDic{
    NSMutableArray *modelArray = [NSMutableArray array];
    NSArray *arr = jsonDic[@"result"][@"list"];
    for (NSDictionary *dic  in arr) {
        CommentModel *model = [[CommentModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [modelArray addObject:model];
    }
    return modelArray;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}



@end
